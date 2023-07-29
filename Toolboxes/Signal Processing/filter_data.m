function filtered_data = filter_data(test_data,Fs,filter_center,width,show_response)
% 
%   This is a function that will be used to filter the data for one 
%   microphone that is collected by the array. This filter will use a 4th 
%   order bandpass butterworth to filter the background noise out of the 
%   data. This will have a 25% band around the center filter frequency, at
%   100kHz.
%   
%
%   Inputs: test_data   --  The raw test data for one column vector
%           Fs  --  The sample frequency of the data.
%           filter_center   --  the center of the passband (NOT REQUIRED, 
%                               WILL DEFAULT TO 80kHz)
%           width   --  a 0-1 percentage width of the passband (NOT
%                       REQUIRED, WILL DEFAULT TO 0.5)
%                    
%   Outputs: filtered_data -- The processed filtered data
%
%   Sam Kramer
%   June 19th, 2023
%

% --Develop filter band
    lower_filt = filter_center - width*filter_center;
    upper_filt = filter_center + width*filter_center;
    filter_band = [lower_filt upper_filt] ./ (Fs/2);

% --Define filter used
    [B,A] = butter(9,filter_band,"bandpass");

% --Frequency Response of filter
    if show_response == "true"
        figure()
        freqz(B,A,[],Fs)
        title('Frequency Response of Created Filter')
    end

% --Filter data and return
    filtered_data = filtfilt(B,A,test_data);
   
end

