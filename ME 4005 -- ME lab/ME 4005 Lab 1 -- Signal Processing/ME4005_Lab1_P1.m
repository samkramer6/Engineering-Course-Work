%% ME4005 Lab1 Part 1 Lab
% Loading in Data and finding statistical indicators of it.

%% Short circuit section
% Set up
clear;clc;format compact; close all;

% Load in Data
load('Lab1_P1_Short'); % Will generate two separate vectors [t,v]

% Calculation of separate indicators
meanV = mean(v)
maxV = max(v)
stdV = std(v)

r = histfit(v); % This will create a Histogram with a bell curve overlaid
    set(r(2), 'color', 'r'); % Changes color of norm dist curve
    title('Histogram of the Short Circuit Data')
    legend('Histogram data','Normal Distribution Curve')
    xlabel('Voltage Values (v)')
    ylabel('Number of Data Points')

%% Open circuit section
% Set up
clear;clc;format compact;close all;

% Load in Data
load('Lab1_P1_Open'); % Will generate two separate vectors [time, voltage]

% Calculations
meanV = mean(v)
maxV = max(v)
stdV = std(v)

r = histfit(v); % This will create a Histogram with a bell curve overlaid
    set(r(2), 'color', 'r'); % This will change color of norm dist curve
    title('Histogram of the Open Circuit Data')
    legend('Histogram data','Normal Distribution Curve')
    xlabel('Voltage Values (v)')
    ylabel('Number of Data Points')

