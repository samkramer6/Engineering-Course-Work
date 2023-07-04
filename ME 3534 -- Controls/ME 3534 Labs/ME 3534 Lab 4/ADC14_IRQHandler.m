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
global FILTNUM FILTDEN RUN_MODE PWM_ENABLE

persistent count filt_in filt_out FILT_ORDER

if isempty(count)  % Initialize only on the very first time
    %  --local counters
    count = 1;

    %  --difference equation memory vectors for the filter
    FILT_ORDER = length(FILTNUM);
    filt_in = zeros(1,FILT_ORDER);
    filt_out = zeros(1,FILT_ORDER);    
end


%  --read the ADC sample from Ch. 1 (14-bit ADC -> 2^14=16384)
adc_sample = MSP432_get_ADC_value(1);  % raw value will be 0 to 16383

%  --scale the raw ADC sample to voltage units
Vsens = 20 * (adc_sample / 16384) - 10;  % this is the feedback measurement


switch RUN_MODE
    case 0      % Idle mode
        %  --disable the PWM output (0 volts)
        Vcontrol = 0;
        
        %  --reset all filter memory to zero (must be row vectors)
        filt_in = zeros(1,FILT_ORDER);
        filt_out = zeros(1,FILT_ORDER);

        %  --force all filter coefficient vectors to be column vectors
        FILTNUM = FILTNUM(:);
        FILTDEN = FILTDEN(:);
        
    case 1      % System Identification mode
        %  --generate a random noise sequence
        Vrand = 20*rand(1) - 10;   % uniform distribution from -10V to +10V
        
        %  --shift the new input sample to the input filter memory vector
        filt_in = [Vrand, filt_in(1:FILT_ORDER-1)];
        
        %  --generate the next filtered output sample
        if (FILT_ORDER == 1)
            %  --no need to process the denominator terms
            Vcontrol = filt_in * FILTNUM;
        else
            Vcontrol = filt_in * FILTNUM -  ...
                filt_out(1:end-1) * FILTDEN(2:end);
        end
        
        %  --shift current output sample into the output filter memory
        filt_out = [Vcontrol, filt_out(1:FILT_ORDER-1)];
        
    case 2      % Feedback Control mode
        %  --not used for Lab 4
        Vcontrol = 0;
end


%  --saturate the control voltage (always best to clip here)
Vcontrol = min(10,Vcontrol);    % saturate at +10V
Vcontrol = max(-10,Vcontrol);   % saturate at -10V


%  --compute the PWM duty cycle for this control voltage
duty_cycle = (Vcontrol + 10) / 20;  % note that: 50% duty_cycle = 0 volts


%  --convert the duty cycle to a PWM count
if PWM_ENABLE
    %  --use the computed duty_cycle here
    pwm_count = round(MSP432_get_PWM_base_period * duty_cycle);
else
    %  --when PWM is disabled, output 50% duty cycle, which is 0 volts
    pwm_count = round(MSP432_get_PWM_base_period / 2);
end


%  --output the PWM signal
MSP432_set_PWM_count(pwm_count);


%  --only save data when enabled and when the buffer is not full
if (START_DAQ && ~BUFFER_FULL)
    %  --save the raw ADC data and the excitation to the buffer
    DATA_BUFFER(count,:) = [Vsens,Vcontrol];
    
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
