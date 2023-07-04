%% ME 4005 Prelab Work
% Lab #1 Prelab Calculations
    % Samuel Kramer
    % 30 Jan 2022
%% Problem 1
% Loading basic data and calculating various metrics
clear;clc;format compact; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Open Data from .txt document
A = importdata('HIP_star.dat.txt'); 

% Extracts and resizes to select only the the visual band magnitude
data = A.data(:,2); 

% Calculate mean, median, mode, range, variance, standard dev,
% quartiles, and inter quartile range.
range = max(data) - min(data)
median = median(data)
mean = mean(data)
mode = mode(data)
standDev = std(data)
variance = standDev^2

    % Quartiles calculations
Q1 = quantile(data,0.25)
Q2 = quantile(data, 0.5)
Q3 = quantile(data, 0.75)

    % Interquartile Range
IQrange = Q3-Q1

%% Problem 2
% Low pass filter calculation and Bode plot
clear;clc;format compact;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Transfer Functions of the simple R-C circuit
    % Transfer function is defined as Tf = Vo/Vin
    % Hf = R/(1+RjwC)
        % R is resistance, jw will be replaced by s in the bode function,
        % C is the capacitance.
% Parameters
R = 3300; C = .33*10^-6;

% Bode function
Hf = tf([0 0 R], [0 R*C 1]);
options = bodeoptions;
options.FreqUnits = 'Hz';
bode(Hf,options);
hold on
Cutoff = ((.5)/(2*pi*R*C))/(2*pi);
fprintf('The cutoff frequency is %3.3f Hz \n', Cutoff);
    
