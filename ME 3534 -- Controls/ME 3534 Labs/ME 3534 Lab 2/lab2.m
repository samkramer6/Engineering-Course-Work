function lab2

% Setup

%  --define global symbols to pass to the interrupt handler
global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ

BUFLEN = 1000; % approx 1 second of data collection
BUFFER_FULL = false;
DATA_BUFFER = zeros(BUFLEN,4);
START_DAQ = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialization of system
    %  --configure the hardware
        MSP432_set_system_clock(48);    % 48 MHz
        timer_clk_hz = 32768;           % frequency of TIMERA clock (Hz)
        MSP432_set_ADC_timer_clock(timer_clk_hz);
        fs = 1000;                      % desired ADC sample rate (Hz)
        timera_period = round(timer_clk_hz / fs); % Period of timer
        MSP432_set_ADC_timer_period(timera_period);

    %  --Enable TIMERA and the ADC data acquisition
    MSP432_enable_interrupts(true);         % Enables The interruptor func

    %  --Initiate LEDs and Switches
    MSP432_set_LED_state('LED1',0);         % turn LED1 off
    MSP432_set_LED_state('LED2',0);         % turn LED2 off
    MSP432_set_switch_state('S1',false);    % turn S1 off
    MSP432_set_switch_state('S2',false);    % turn S2 off

%%%%%%%%%%%%%%%%%%%%%%%%%%% Background Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start the background loop
while(~MSP432_test_for_reset)
    
    % --Toggles DAQ to enable Data Acquisition
    if (MSP432_get_switch_state('S1') == true)
        
        %  --Turn off switch S1
        MSP432_set_switch_state('S1',false);
        
        %  --Toggle LED1
        led1state = MSP432_get_LED_state('LED1');
        led1state = ~led1state;
        MSP432_set_LED_state('LED1',led1state);
            MSP432_set_LED_state('LED2',0);     % Keeps LED2 off
        
        %  --Set the run mode for the interrupt handler
        START_DAQ = led1state; % Starts data acquisition
        
    end
 
    
    %  --Check if Buffer is full of data
    if (BUFFER_FULL == true)
        
        %  --Buffer is full, writes to matrix 'data'
        MSP432_write_data_to_workspace('data',DATA_BUFFER);
   
        % --Clear Buffer, toggle DAQ
        BUFFER_FULL = false;  % prevent continuous writing to workspace
        START_DAQ = false;    % disable data acquisition
        
        % --Toggle off LED1 and toggle LED2
        MSP432_set_LED_state('LED1',0);  % turn off LED1
        MSP432_set_LED_state('LED2',2);  % turn LED2 (green) on to indicate done
        
    end
    
    %  --wait before repeating the loop
    pause(0.01)    % seconds
end

return
