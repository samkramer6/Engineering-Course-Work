%% Partial Fractions Calculations In Matlab
% Example from class showing how to properly calculate a 
clear;clc;format compact;close all;

% [S^2 - S + 1] / [(S^2 + 3S)((S+1)^2)(S^2 + 4s + 16)]

B = [1 -1 1]; % Defines the Numerator

    % A Method 1
% A = poly([0, -1, -1, -3, -2+2j*sqrt(12), -2-j*sqrt(12)]); % Defines the denominator function from example

    % A Method 2
A = conv([1 3 0], conv([1 2 1], [1 4 16]));

[R,P,K] = residue(B,A)  % Compute the Residue(Which we are solving for)
                        % Pole Locations in P vector
                        % K is the direct terms before (Cases where N < M)
                        