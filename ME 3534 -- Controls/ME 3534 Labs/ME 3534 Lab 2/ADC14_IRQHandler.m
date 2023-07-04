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

% Setup

global DATA_BUFFER BUFLEN BUFFER_FULL START_DAQ

persistent count % Persistent to maintain value if exited and entered

if isempty(count), count = 1; end  % Initialize 'count' on first iteration

    %  --Read the raw ADC (14-bit ADC = 16384 different values)
    adc_sample = MSP432_get_ADC_value([1,2]);  % raw value will be 0 to 16383

    %  --scale the raw ADC sample to voltage units
    vmatrix = linspace(0,2.5,16384);
    v1 = vmatrix(1 + adc_sample);
    v2 = v1 - 1.25;
    vsens = v2./(10^(-18.06/20));
    
    %  --Saves data if DAQ enabled and Buffer not full
    if (START_DAQ && ~BUFFER_FULL)
        %  --save the raw ADC data to the buffer
        DATA_BUFFER(count,:) = [adc_sample vsens];

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
