function coherence_function = coherence(input, output)
%
%   This function finds the coherence between two related data sets. The
%   coherence can be used to quantify the quality of one signal by
%   comparing it to a signal of good quality.
%
%   Inputs: input   ==  Dataset in question, must be an ensemble matrix
%           output  ==  High quality data set used to check the quality of
%                       the input
%   Ouputs: coherence_function  ==  This is the coherence function gamma
%                                   squared of your data
%
%   Sam Kramer
%   July 15th, 2023
%
%   See also crossspec and autospec

    % --Finding Gxx and etc..
        Gxx = autospec(input);
        Gyy = autospec(output);
        Gxy = crossspec(input,output);
        Gyx = crossspec(output,input);
        
    % --Compute Gamma square coherence
        gamma_squared = (abs(Gxy.*Gyx)) ./ (Gxx.*Gyy);
        gamma_squared = gamma_squared / (width(input)^2);
        
    % --Save gamma_squared
        coherence_function = (gamma_squared);
end