%% Controls Engineering Notes                                   1/24/2022
% Lecture on Laplace transforms and the symbolic toolbox
% The command is 'laplace()' for laplace function and then the 'syms'
% declares the symbols that we will use in the calculation.

% Example:
clc;clear;format compact; close all;

syms s t w a

laplace(exp(-a*t)) % Exponential

laplace(heaviside(t)) % Step Function

laplace(sin(w*t))  % Sinusoid

laplace(exp(-a*t)*sin(w*t)) % Damped sinusoid

% Can use Laplace tables from canvas in order to figure out the selected
% problem that you are trying to solve, can also use your memory.

