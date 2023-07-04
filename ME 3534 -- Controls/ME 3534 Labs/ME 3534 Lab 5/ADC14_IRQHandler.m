function ADC14_IRQHandler
%  This function handles interrupts from the ADC14 analog-to-digital
%  converter (emulated) on the MSP432 microcontroller.  When an ADC sample
%  conversion is complete, the ADC hardware issues an interrupt to the
%  processor, which activates this function.
%
%  This function can NOT have any inputs or outputs, so all signals must be
%  passed through global variables.
%
%  When exiting this function, all local variables are cleared. If you need
%  to retain the value in a local variable, it must be declared as
%  persistent (the equivalent in C would be a static declaration).
%
%  Global variables cannot be declared as persistent

global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ
global NUMLPF DENLPF RUN_MODE PWM_ENABLE NUMCONTROL DENCONTROL

persistent count lpf_in lpf_out control_in control_out
persistent refcount refstate Vref LPF_ORDER CONTROL_ORDER

if isempty(count)  % Initialize only on the very first time
    %  --local counters
    count = 1;
    refcount = 0;
    refstate = 0;
    Vref = 0;
    
    %  --difference equation memory vectors
    LPF_ORDER = length(DENLPF);
    lpf_in = zeros(1,LPF_ORDER);
    lpf_out = zeros(1,LPF_ORDER);
    
    CONTROL_ORDER = length(DENCONTROL);
    control_in = zeros(1,CONTROL_ORDER);
    control_out = zeros(1,CONTROL_ORDER);
end


%  --read the ADC samples (14-bit ADC -> 2^14=16384)
adc_sample = MSP432_get_ADC_value;  % raw value will be 0 to 16383

%  --scale the raw ADC samples to voltage units
Vsens = 20 * (adc_sample / 16384) - 10;  % this is the feedback measurement


switch RUN_MODE

    case 2      % Feedback Control mode
        
        %  --Generate a reference signal using a finite state machine
        switch refstate
            case 0 % wait for START_DAQ
                if START_DAQ
                    refstate = 1;
                end
                
            case 1 % first stage cosine rise for 0.5 seconds
                Vref = 4-4*cos(pi*refcount/500);
                refcount = refcount + 1;
                if (refcount == 500)
                    % --reset reference counter and transition to next state
                    refcount = 0;
                    refstate = 2;
                end
                
            case 2 % second stage dwell for 1.5 seconds
                Vref = 8;   % voltage value at step
                refcount = refcount + 1;
                if (refcount == 1500)
                    % --reset reference counter and transition to next state
                    refcount = 0;
                    refstate = 3;
                end
                
            case 3 % third stage ramp for 2 seconds
                Vref = Vref - (13/2000);  % ramp the reference down
                refcount = refcount + 1;
                if (refcount == 2000)
                    % --reset reference counter and transition to next state
                    refcount = 0;
                    refstate = 4;
                end
                
            case 4 % fourth stage dwell for 1 second
                Vref = -5;  % voltage value at dwell
                refcount = refcount + 1;
                if (refcount == 1000)
                    % --reset reference counter and transition to next state
                    refcount = 0;
                    refstate = 5;
                end
                
            case 5 % fifth stage ramp for 0.1 second
                Vref = Vref + (5/100);
                refcount = refcount + 1;
                if (refcount == 100)
                    % --reset reference counter and transition to next state
                    refcount = 0;
                    refstate = 6;
                end
                
            case 6 % sixth stage dwell for 1.9 seconds
                Vref = 0;  % voltage value at dwell
                refcount = refcount + 1;
                if (refcount == 1900)
                    % --reset reference counter and transition to next state
                    refcount = 0;
                    refstate = 1;
                end
        end
        
        %  --compute the error signal
        error = Vref - Vsens;
        
        
        %  --evaluate the control law (general z-domain transfer function)
        %             -----------------
        %   error(z)  | NUMCONTROL(z) |  Vcontrol(z)
        %  ---------->| ------------- |-------------->
        %             | DENCONTROL(z) |
        %             -----------------
        
        %  --shift the new input sample to the input filter memory
        control_in = [error, control_in(1:CONTROL_ORDER-1)];
        
        %  --generate the next controller output sample
        if (CONTROL_ORDER == 1)
            %  --no need to process the denominator terms
            Vcontrol = control_in * NUMCONTROL;
        else
            Vcontrol = control_in * NUMCONTROL - control_out(1:end-1) * DENCONTROL(2:end);
        end
        
        %  --shift current output sample to the output filter memory
        control_out = [Vcontrol, control_out(1:CONTROL_ORDER-1)];
end

%  --saturate the control voltage
Vcontrol = min(10,Vcontrol);    % saturate at +10V
Vcontrol = max(-10,Vcontrol);   % saturate at -10V

%  --compute the PWM duty cycle for this control voltage
duty_cycle = (Vcontrol + 10) / 20;  % 50% duty_cycle = 0 volts

%  --convert the duty cycle to a PWM count
if PWM_ENABLE
    pwm_count = round(MSP432_get_PWM_base_period * duty_cycle);
else
    %  --when PWM is disabled, output 50% duty cycle, which is 0 volts
    pwm_count = round(MSP432_get_PWM_base_period / 2);
end

%  --output the PWM signal
MSP432_set_PWM_count(pwm_count);


%  --only save data when enabled and when the buffer is not full
if (START_DAQ && ~BUFFER_FULL)
    %  --save the raw ADC data to the buffer
    DATA_BUFFER(count,:) = [Vsens,Vcontrol,Vref];
    
    if (count == BUFLEN)
        %  --reset counter and notify for a full buffer
        count = 1;
        BUFFER_FULL = true;
    else
        %  --increment counter for the next sample
        count = count + 1;
        BUFFER_FULL = false;
    end
end

return
