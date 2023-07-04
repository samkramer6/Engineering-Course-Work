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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ
global INITIALIZE_FILTERS aNot bNot aBut bBut

persistent count Buk2 Buk1 Byk2 Byk1 Nuk2 Nuk1 Nyk1 Nyk2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isempty(count), count = 1; end

%  -- Read the raw ADC samples (14-bit ADC -> 2^14=16384)
adc_sample = MSP432_get_ADC_value([1,2]);  % raw value will be 0 to 16383

%  -- Scale the raw ADC samples to voltage units
Vsens1 = 20 * (adc_sample(1) / 16384) - 10;
Vsens2 = 20 * (adc_sample(2) / 16384) - 10;

if INITIALIZE_FILTERS
    
    %  --reset all the filter memory to zero
    
    Vfilt1 = 0;
    Vfilt2 = 0;
    
    % -- Initialize all the prior values
        % This is necessary in order to prevent Maxtrix issues
        
    Buk2 = 0;   % x(n - 2)
    Buk1 = 0;   % x(n - 1)
    Byk2 = 0;   % y(n - 2)
    Byk1 = 0;   % y(n - 1)
    
    Nuk2 = 0;
    Nuk1 = 0;
    Nyk2 = 0;
    Nyk1 = 0;
    
else
    %  -- filter Vsens2 with a butterworth low-pass digital filter
        % a1*y(k) = b1*u(k) + b2*u(k-1) + b3*u(k-2) - a2*y(k-1) - a3*y(k-2)
        
    Vfilt2 = bBut(1)*Vsens2 + bBut(2)*Buk1 + bBut(3)*Buk2 - aBut(2)*Byk1 - aBut(3)*Byk2;
    
    %  -- filter Vsens1 with a digital notch filter
        % a1*y(k) = b1*u(k) + b2*u(k-1) + b3*u(k-2) - a2*y(k-1) - a3*y(k-2)
            % This equation is auto generated by the filter(B,A,X) function
   
    Vfilt1 = bNot(1)*Vsens1 + bNot(2)*Nuk1 + bNot(3)*Nuk2 - aNot(2)*Nyk1 -aNot(3)*Nyk2; 
    
    % --Reset the values
        % Makes the current k-1 values the k-2 values for the next loop
        
        Byk2 = Byk1;        % Changes the Butterworth diff eqn values
        Buk2 = Buk1;
        Byk1 = Vfilt2;
        Buk1 = Vsens2;
        
        Nyk2 = Nyk1;        % Changes the Notch diff eqn values
        Nuk2 = Nuk1;
        Nyk1 = Vfilt1;
        Nuk1 = Vsens1;
    
end

%  --Only save data when enabled and when the buffer is not full

if (START_DAQ && ~BUFFER_FULL)
    
    %  -- Save signals to the data buffer
    DATA_BUFFER(count,:) = [Vsens1,Vfilt1,Vsens2,Vfilt2];
    
    if (count == BUFLEN)
        
        %  -- Reset counter and notify for a full buffer
        count = 1;
        BUFFER_FULL = true;
        
        %  -- Turn on the filters after the first sample
        INITIALIZE_FILTERS = true;
        
    else
        
        %  -- Increment counter for the next sample
        count = count + 1;
        BUFFER_FULL = false;
        
        %  -- Turn off the filters after the last sample
        INITIALIZE_FILTERS = false;
        
    end
    
end

return
