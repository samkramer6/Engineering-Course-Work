function freq_response = FRF(data1, data2)
% 
%   This function is the frequency response function for two given sets of
%   data. The frequency response function is the measurement of a system's
%   excitement to a specific frequency. A signal will have a larger FRF
%   amplitude when the mechanical system creating that signal responds more
%   powerfully to that excitation frequency. FRF is defined as:
%
%                    (conj(F{x})*F{y})./(F{x}*conj(F{x})
%                   or the cross_spectrum / autospectrum
%
%   Sam Kramer
%   July 15, 2023
%
%   See also coherence, autospec, and crossspec

% --Taking FRF
    freq_response = abs( crossspec(data1,data2) ) ./ autospec(data1);

end