function specfilt_data(data,time_start,time_end)
%
%   This function will take the filtered spectrogram of a single data set
%   that is plugged into the function. This has set filter settings that
%   can be changed if you go into the code and change the settings. 
%   
%   Inputs:
%           data    ==  Single row vector that contains the data you wish
%                       to see the spectrogram and filter. If you have an
%                       ensemble of row vectors, zero mean the data and
%                       then mean across the rows using mean(x,2).
%           time_start  ==  The time start of the data you would like to
%                           visualize (s).
%           time_end    ==  The time end of the data you would like to
%                           visualize (s).
%
%   Sam Kramer
%   July 14th, 
%   
%   See also filter_data, spectrogram_data
%

% --Find ind = 1
    ind1 = find(data(1:end,1) == time_start);
    ind2 = find(data(1:end,1) == time_end);
    fs = 1/(data(4,1) - data(3,1));

% --Pull in data
    data = data(ind1:ind2,1);

    data = data - mean(data);

% --Filter data [CHANGE IF NEEDED]
    filtered_data = filter_data(data,fs,80000,0.25,"False");

% --Finding Spectrogram
    figure()
    [s,f,t] = spectrogram(filtered_data, hamming(128), 124, [], fs,'yaxis');
        t = time_start:(1/length(t)):time_end;
        s = 20*log10(abs(s));
        s = s - max(s);
        imagesc(t,f,s)
        set(gca,"YDir","normal")
        clb = colorbar;
        clim([-60 0])
        title('Spectrogram of Data')
        xlabel('Time (s)');
        ylabel('Frequency (Hz)')
        clb.Title.String = "Power (dB)";

end