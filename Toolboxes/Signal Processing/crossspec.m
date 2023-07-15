function cross_spect = crossspec(data1,data2)
% 
%   This function performs the cross-spectrum of two data sets where data1
%   is the data in question for the data set. The cross spectrum is a tool
%   that is used to find the dominant frequency within a signal by checking
%   it across another template signal and is given as:
%
%                       conj(F{x}) * F{y}
%
%   Inputs: data1   ==  A column vector where you would like to analyze the
%                       frequencies of the signal
%           data2   ==  The template data vector you would like to check
%                       your dataset across
%
%   Outputs: cross_spect    ==  The cross-spectrum of your dataset.
%
%   Sam Kramer
%   July 15th, 2023

% --Setup
    cross_spect = zeros(length(data1),1);

% --Compute autospectrum of data
    for i = 1:width(data1)
    
        % --Take FFT of Column data
            fftdata1 = fft(data1(:,i));
            fftdata2 = fft(data2(:,i));
        
        % --Find cross-spectrum and add it to previous value by (X*)(Y)
            cross = conj(fftdata1) .* fftdata2;
            cross = 2 .* cross / length(data1);
            cross_spect = cross_spect + cross;
    
    end
    
% --Normalize
    cross_spect = cross_spect / (width(data1));

end