function lab3

%  -- Define global symbols to pass to the interrupt handler
    global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ
    global INITIALIZE_FILTERS aBut bBut aNot bNot

    BUFLEN = 500;  % Approximately 0.5 seconds of data collection
    BUFFER_FULL = false;
    DATA_BUFFER = zeros(BUFLEN,4);
    START_DAQ = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Configuring %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Hardware parameters
    MSP432_set_system_clock(48);        % 48 MHz
    timer_clk_hz = 32768;               % frequency of TIMERA clock (Hz)
    MSP432_set_ADC_timer_clock(timer_clk_hz);
    fs = 1000;                          % desired ADC sample rate (Hz)
    timera_period = round(timer_clk_hz / fs);
    MSP432_set_ADC_timer_period(timera_period);

% --Notch Filter parameters
    Wn = 10;            % Notch Frequency (hz)
    zZeros = 0.003;     % Damping Ratio for Zeros
    zPoles = 0.3;       % Damping Ratio for Poles
    K = 2*fs;           % K coefficient in Notch filter 

%%%%%%%%%%%%%%%%%%%%%%%%%% Filter Coefficients %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Creates the butterworth low-pass filter
    % Will follow difference eqn:
        % a1*y(n) = b1*x(n) + b2*x(n-1) + b3*x(n-2) - a2*y(n-1) - a3*y(n-2)
    Wb = 3.175/(fs/2);
    [bBut,aBut] = butter(2,Wb); % Filter Creation
   
% --Creates a notch low-pass filter
    % Will follow the difference eqn:
        % a1*y(n) = b1*x(n) + b2*x(n-1) + b3*x(n-2) - a2*y(n-1) - a3*y(n-2)
            %  -- a(1) must be equal to 1
    notchDenom = (K + 2*zPoles*Wn*K + Wn^2);
    
    % --a vector coefficient equation
        a1Notch = 1;
        a2Notch = (2*Wn^2 - 2*K)/notchDenom;
        a3Notch = (K - 2*zPoles*Wn*K + Wn^2)/notchDenom;
    
    % --b vector coefficient equations 
        b1Notch = (K + 2*zZeros*Wn*K + Wn^2)/notchDenom;
        b2Notch = (K - 2*zZeros*Wn*K + Wn^2)/notchDenom;
        b3Notch = (2*Wn^2 - 2*K)/notchDenom;
        
    % --Store Filter Coefficients
        aNot = [a1Notch a2Notch a3Notch];
        bNot = [b1Notch b2Notch b3Notch];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Initialize filters at startup
    INITIALIZE_FILTERS = true;              % Enables Filters

% --Finally enable TIMERA and the ADC data acquisition
    MSP432_enable_interrupts(true);         % Enables Interupt Func

% --Initialize LEDs and Switches to proper position
    MSP432_set_LED_state('LED1',0);         % turn LED1 off
    MSP432_set_LED_state('LED2',0);         % turn LED2 off
    MSP432_set_switch_state('S1',false);    % turn S1 off
    MSP432_set_switch_state('S2',false);    % turn S2 off

%%%%%%%%%%%%%%%%%%%%%%%%%%% Background Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while(~MSP432_test_for_reset)
    
    % -- Enable or disable data acquisition
    if (MSP432_get_switch_state('S1') == true)
        
        % -- Turn off switch S1
        MSP432_set_switch_state('S1',false);
        
        % -- Toggle LED1
        led1state = MSP432_get_LED_state('LED1');
        led1state = ~led1state;
            MSP432_set_LED_state('LED1',led1state);
            MSP432_set_LED_state('LED2',0);     % Ensure LED2 off
        
        % -- Toggle interrupt handler
        START_DAQ = led1state;
        
    end
    
    % -- Check to see if we have a full buffer of data
    if BUFFER_FULL
        
        % -- Buffer is full, write the data to the workspace
        MSP432_write_data_to_workspace('data',DATA_BUFFER);
        
        % -- Clear Buffer, Toggle DAQ
        BUFFER_FULL = false;  % disable writing to workspace
        START_DAQ = false;    % disable data acquisition
        
        % -- Turn off LED1, turn on LED2
        MSP432_set_LED_state('LED1',0);  % turn off LED1
        MSP432_set_LED_state('LED2',2);  % turn LED2 on
        
    end
    
    %  --wait before repeating the loop
    pause(0.01)    % seconds
    
end

return
