function lab4

%  --define global symbols to pass to the interrupt handler
global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ
global FILTNUM FILTDEN RUN_MODE PWM_ENABLE

persistent count
if isempty(count), count = 1; end

BUFLEN = 16500;  % change this value to collect more or less data
BUFFER_FULL = false;
DATA_BUFFER = zeros(BUFLEN,2);
START_DAQ = false;
PWM_ENABLE = false;
RUN_MODE = 0;  % default run mode is idle


%  --configure the hardware
MSP432_set_system_clock(48);    % 48 MHz

timer_clk_hz = 32768;   % frequency of TIMERA clock (Hz)
MSP432_set_ADC_timer_clock(timer_clk_hz);

fs = 1000;      % desired ADC sample rate (Hz)

timera_period = round(timer_clk_hz / fs);
MSP432_set_ADC_timer_period(timera_period);

MSP432_set_PWM_base_frequency(20000);   % 20000 Hz

max_pwm_count = MSP432_get_PWM_base_period;
MSP432_set_PWM_count(round(max_pwm_count/2));  % initialize at 50% duty cycle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  --design a Butterworth band-pass filter (change these parameters)
order = 2;
fbreak = [0.5 20];    % Hz
gain = 1.5;

[FILTNUM,FILTDEN] = butter(order,fbreak/(fs/2));

FILTNUM = gain * FILTNUM;


%  --finally enable TIMERA and the ADC data acquisition
MSP432_enable_interrupts(true);


%  --turn off user LED's and switches at startup
MSP432_set_LED_state('LED1',0);     % turn LED1 off
MSP432_set_LED_state('LED2',0);     % turn LED2 off
MSP432_set_switch_state('S1',false);    % turn S1 off
MSP432_set_switch_state('S2',false);    % turn S2 off


%  --start the infinite background loop
while(~MSP432_test_for_reset)
    
    %  --check the S1 switch (enable or disable data acquisition)
    if (MSP432_get_switch_state('S1') == true)
        %  --first turn off switch S1
        MSP432_set_switch_state('S1',false);
        
        %  --turn on LED1
        MSP432_set_LED_state('LED1',true);
        count = 1;  % reset the counter
        
        %  --start data acquisition in the interrupt handler
        START_DAQ = true;
        
        %  --allow the PWM signal to drive the output
        PWM_ENABLE = true;
    end
 
    
    %  --check the S2 switch (change the operating mode)
    if (MSP432_get_switch_state('S2') == true)
        %  --first turn off switch S2
        MSP432_set_switch_state('S2',false);
        
        %  --get the current LED2 state
        led2state = MSP432_get_LED_state('LED2');
        
        %  --increment the LED2 state
        if (led2state == 0)
            %  --change to the system ID mode
            led2state = 3;  % use blue LED
            RUN_MODE = 1;
        elseif (led2state == 3)
            %  --change to the control mode
            led2state = 2;  % use green LED
            RUN_MODE = 2;
        else
            %  --change to the off mode
            led2state = 0;  % all RGB off (black)
            RUN_MODE = 0;
        end
                    
        %  --set the new state for LED2
        MSP432_set_LED_state('LED2',led2state);
    end
 
    
    %  --check to see if we have a full buffer of data
    if BUFFER_FULL
        %  --buffer is full, so write the data to the workspace
        MSP432_write_data_to_workspace('data',DATA_BUFFER);
                
        BUFFER_FULL = false;  % prevent continuous writing to workspace
        START_DAQ = false;    % disable data acquisition
        PWM_ENABLE = false;   % disable the PWM output
        MSP432_set_LED_state('LED1',0);  % turn off LED1
    end
    
    
    %  --increment a local counter during data acquisition
    if START_DAQ
        count = count + 1;
        if (count > 50)
            %  --reset the counter after 50 counts (approx. 1/2 second)
            count = 1;    
            
            %  --get the current LED1 state
            led1state = MSP432_get_LED_state('LED1');
            
            %  --toggle the LED1 state (flash on/off every 1/2 second)
            MSP432_set_LED_state('LED1',~led1state);
        end
    end
    
    %  --wait before repeating the loop
    pause(0.01)    % seconds
end

return
