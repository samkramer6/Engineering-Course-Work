function auto_spect = autospec(data)
%
%   This function is the autospectrum of the data that is presented to the
%   function. The autospectrum of the data gives the power of the data
%   related to each frequency. This is used for discrete-stationary data
%   and should not be used for noise. The autospectrum is given as:
%                           F{x} * conj(F{x})
%   
%   Inputs:     data    ==  This is the data that is taken and you wish to
%                           see the autospectrum of. This data must be
%                           taken as a single column vector.
%   Outputs:    auto_spec ==   The single-sided auto spectrum of the data
%
%   Sam Kramer
%   July 15th, 2023
%
%   See also: spectrogra_data and filter_data
%   

    % --Setup
        auto_spect = zeros(length(data),1);
    
    % --Compute autospectrum of data
        for i = 1:width(data)
        
            % --Take FFT of Column data
                fftdata = fft(data(:,i));
            
            % --Find autospectrum and add it to previous value
                auto = fftdata .* conj(fftdata);
                auto = auto * 2 / (length(data)*width(data));
                auto_spect = auto_spect + auto;
        
        end
        
    % --Normalize
        auto_spect = auto_spect/ (width(data));
        
end