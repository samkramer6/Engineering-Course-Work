function lab5

clear ADC14_IRQHandler

%  -- Define global/persistent symbols 
    % Global
    global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ
    global NUMLPF DENLPF RUN_MODE PWM_ENABLE NUMCONTROL DENCONTROL

    % Persistent
    persistent count
    if isempty(count), count = 1; end

%%%%%%%%%%%%%%%%%%%%%%%%% Hardware Configuration %%%%%%%%%%%%%%%%%%%%%%%%%%
    
% -- Configure Hardware
BUFLEN = 14000;  % do NOT change this value
BUFFER_FULL = false;
DATA_BUFFER = zeros(BUFLEN,3);
START_DAQ = false;
PWM_ENABLE = false;
RUN_MODE = 0;

MSP432_set_system_clock(48);    % 48 MHz

timer_clk_hz = 32768;   % Frequency of TIMERA clock (Hz)
MSP432_set_ADC_timer_clock(timer_clk_hz);

fs = 1000;      % Desired ADC sample rate (Hz)

timera_period = round(timer_clk_hz / fs);
MSP432_set_ADC_timer_period(timera_period);

MSP432_set_PWM_base_frequency(20000);   % 20000 Hz

max_pwm_count = MSP432_get_PWM_base_period;
MSP432_set_PWM_count(round(max_pwm_count/2));  % initialize at 50% duty cycle

%%%%%%%%%%%%%%%%%%%%%%%%%% Motor Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Define motor parameters
j = 2.5*10^-5;      % Total rotational inertia 
b = 1*10^-6;        % Tota rotational damping
Kt = 0.042;         % Torque constant
Ke = 0.042;         % Velocity constant
L = 1.16*10^-3;     % Motor inductance
R = 8.4;            % Motor resistance

% -- LTI transfer function of motor
num = [0 0 0 Kt];
denom = [L*j (R*j + L*b) (R*b + Ke*Kt) 0 ];
motor = tf(num,denom); % Plant open loop transfer function (In Laplace form)

%%%%%%%%%%%%%%%%%%%%%%%%%%% Compensator Design %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  -- Design the discrete-time compensator

design_selector = 3;    % change this value to select a new design

switch design_selector
    case 1  % Proportional control
        KP = 4;
        
        NUMCONTROL = KP;
        DENCONTROL = 1;
        
    case 2  % Proportional + Integral control
        KP = 3.5;
        KI = 1.5;
        
        num = [KP KI];
        den = [1 0];
        
        [NUMCONTROL,DENCONTROL] = c2dm(num,den,1/fs,'tustin');
        
    case 3  % PID control
        
            % PID Control
        K = 2.5;                            % PID Static Gain
        control = pidtune(motor,'PIDF');    % PIDTUNE function determin Kd
        control = tf(control);              % Definition of control TF
        control = control * K;              % Multiply control by gain
        
            % Low Pass Filter
        numLP = [1];
        denomLP = [0.001 1];
        LPcontrol = tf(numLP,denomLP);
        
            % Cascade two controllers
        control = control * LPcontrol;
            
        [num,den] = tfdata(control,'v');  % extract coefficient vectors
        
        [NUMCONTROL,DENCONTROL] = c2dm(num,den,1/fs,'tustin');
     
    case 4  % lead compensator
        
            % Lead compensator design
        num = [1 1];
        denom = [1 4];
        gain = 4;
        
        C = tf(num,denom);
        C = C*gain;
        
            % Low pass filter design
                % first order low pass, will have a break frequency of
                % 1/(2*pi*0.001) hz
        numLP = [1];
        denomLP = [0.001 1];
        LPcontrol = tf(numLP,denomLP);
        
            % Cascade two controllers
        C = C*LPcontrol;
        
        [num,den] = tfdata(C,'v');  % extract coefficient vectors
        
        [NUMCONTROL,DENCONTROL] = c2dm(num,den,1/fs,'tustin');

end

%  -- Normalize the discrete-time numerator and denominator coefficients
NUMCONTROL = NUMCONTROL / DENCONTROL(1);
DENCONTROL = DENCONTROL / DENCONTROL(1);


%  -- Finally enable TIMERA and the ADC data acquisition
MSP432_enable_interrupts(true);


%  -- Turn off user LED's and switches at startup
MSP432_set_LED_state('LED1',0);     % turn LED1 off
MSP432_set_LED_state('LED2',0);     % turn LED2 off
MSP432_set_switch_state('S1',false);    % turn S1 off
MSP432_set_switch_state('S2',false);    % turn S2 off

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Background Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  -- Start the infinite background loop
while(~MSP432_test_for_reset)
    
    %  -- Check the S1 switch (enable or disable data acquisition)
    if (MSP432_get_switch_state('S1') == true)
        
        %  -- First turn off switch S1
        MSP432_set_switch_state('S1',false);
        
        %  -- Turn on LED1
        MSP432_set_LED_state('LED1',true);
            count = 1;  % reset the counter
        
        %  -- Start data acquisition
        START_DAQ = true;
        
        %  -- Allow the PWM signal to drive the output
        PWM_ENABLE = true;
        
    end
 
    
    %  -- Check the S2 switch (change the operating mode)
    if (MSP432_get_switch_state('S2') == true)
        
        %  -- First turn off switch S2
        MSP432_set_switch_state('S2',false);
        
        %  -- Get the current LED2 state
        led2state = MSP432_get_LED_state('LED2');
        
        %  -- Increment the LED2 state
        if (led2state == 0)
            
            %  -- Change to the system ID mode
            led2state = 3;  % use blue LED
                RUN_MODE = 1;
                
        elseif (led2state == 3)
            
            %  -- Change to the control mode
            led2state = 2;  % use green LED
            RUN_MODE = 2;
            
        elseif (led2state == 2)
            
            %  -- Change to the off mode
            led2state = 0;  % all RGB off (black)
            RUN_MODE = 0;
            
        end
                    
        %  -- Set the new state for LED2
        MSP432_set_LED_state('LED2',led2state);
    end
 
    
    %  -- Check to see if we have a full buffer of data
    if BUFFER_FULL
        %  --buffer is full, so write the data to the workspace
        MSP432_write_data_to_workspace('data',DATA_BUFFER);
        
        %  --save the data to a mat-file
        data = DATA_BUFFER;
        save(strcat('data',int2str(design_selector),'.mat'),'data');
                
        BUFFER_FULL = false;  % prevent continuous writing to workspace
        START_DAQ = false;    % disable data acquisition
        PWM_ENABLE = false;   % disable the PWM output
        MSP432_set_LED_state('LED1',0);  % turn off LED1
    end
    
    
    %  --increment the counter during data acquisition
    if START_DAQ
        count = count + 1;
        if (count > 50)
            count = 1;    % reset the counter after 50 counts (~1/2 second)
            
            %  --check the current LED1 state
            led1state = MSP432_get_LED_state('LED1');
            
            %  --toggle the state of LED1
            MSP432_set_LED_state('LED1',~led1state);
        end
    end
    
    %  --wait before repeating the loop
    pause(0.01)    % seconds
end

return
