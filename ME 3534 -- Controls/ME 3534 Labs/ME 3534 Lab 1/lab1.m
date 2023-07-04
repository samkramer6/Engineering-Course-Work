function lab1
%  This is the template program for lab1.

%  Submitted by:  Samuel Kramer
%  Submitted on:  1/27/2022

%  --initialize the hardware at startup

MSP432_set_LED_state('LED1',0);         % turn LED1 off
MSP432_set_LED_state('LED2',0);         % turn LED2 off
MSP432_set_switch_state('S1',false);    % turn S1 off
MSP432_set_switch_state('S2',false);    % turn S2 off

%  --start the infinite background loop
% Initialize control variables
dir = 1; % State Direction variable to tell what direction the loop is going in
on = 0; % State Power variable to tell if it is on or not
while(~MSP432_test_for_reset) % Do not change this line
    
    %  --read the S1 and S2 switches
    S1state = MSP432_get_switch_state('S1');
    S2state = MSP432_get_switch_state('S2');
    
    %  --read the LED1 and LED2 states
    LED1state = MSP432_get_LED_state('LED1');
    LED2state = MSP432_get_LED_state('LED2');
    

            % If S1 is on, turn on/off
        if  S1state == true 
            
            % Flip variable
            if LED2state == 0 && on == 0 % checks to see if LED is off
                on = 1;
            else % If LED is on turn off and revert direction back to normal
                on = 0;
                dir = 1;
            end
            
            % Turn S1 off
            MSP432_set_switch_state('S1', false) 
            
        end 
        
        if S2state == true
            
            % Flip Variable
            if dir == 1 %if Direciton is normal reverse it
                dir = -1;
            elseif dir == -1 % If direction is reverse flip to normal
                dir = 1;
            end
            
            % Turn S2 off
            MSP432_set_switch_state('S2',false);
            
        end
        
        % Increment/decrement lights
        if on == 1 % If it is on increment/decrement
            
            if dir == 1
                LED2state = LED2state + 1;
                if (LED2state >= 8), LED2state = 0; end
                MSP432_set_LED_state('LED2',LED2state);
            
            else 
                LED2state = LED2state - 1;
                if (LED2state <=-1), LED2state = 7; end
                MSP432_set_LED_state('LED2',LED2state);
            end  
            
        elseif on == 0 % if it is off, turn LED to black and keep it there
                
            % Turn off LED
            LED2state = 0;
            MSP432_set_LED_state('LED2', LED2state);
               
        end

    %  --wait before repeating the loop
    pause(1)    % seconds
    
end
return
