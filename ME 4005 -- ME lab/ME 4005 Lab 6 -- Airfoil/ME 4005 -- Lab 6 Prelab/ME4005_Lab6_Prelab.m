%% ME 4005 Lab 6 Prelab
% Sam Kramer                                                    16 Apr 2022
% This is the work and the plot data for the two different calibration
% plots for Lab 6 Prelab
% Will return:
%               1. 1 graph with the 2 calibration curves for both the
%               pressure gauge equation and the voltage divider equation as
%               well as selected points at Pmeasured = -2,-1,0,1,2 inches
%               H20
%
% The experimental setup looks like:
%                                                ____________________
%                     ___________               |       MSP432       |
%        ____________|           |______________|__o SV Termial      |
%       |            |  Pressure |       _______|___[] Channel 1     |
%       |            |   Gauge   |      | |     |   [] Channel 2     |
%       |          __|___________|      | |     |   [] Channel 3     |
%       |         |                     | |     |   [] Channel 4     |
%       |        Vin                    | |     | o ground           |
%       |         |_______              | |     |_|__________________|
%       |                 |             | |       |
%       |                 R1            | |       |
%       |                 |_____Vout____| |       |
%       |                 R2              |       |
%       |                 |_______________|       |
%       |                                         |
%       |_________________________________________|

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Work %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Set up
clear; clc; format compact; close all;

% -- Parameters
Vmax = 4.5;         % Max voltage output from pressure gauge(Volts)
Vmin = 0.5;         % Min voltage input from pressure gauge(Volts)
Pmax = 5;           % Max pressure reading (in H2O)
Pmin = -5;          % Min pressure reading (in H2O)
R1 = 1800;          % Voltage divider resistance 1 (Ohms)
R2 = 1200;          % Voltage divider resistance 2 (Ohms)
P = -5:1:5;         % Pressure Vector (in H2O)

% -- Pressure gauge equation Va
    % This is the voltage generated from the pressure gauge reading the
    % pressure differential in the pitot tube
    % Follows equation:
    %   Vout = ((Vmax - Vmin)/(Pmax - Pmin))*(P - Pmin) + Vmin
Va = ((Vmax - Vmin)/(Pmax - Pmin))*(P - Pmin) + Vmin;

% -- Voltage divider equation Vb
    % This will be the voltage output that will be input into the MSP432
    % and then compiled in the data files.
    % Follows equation: 
    %   Vout = (Vin * R2) / (R1 + R2)
Vb = (Va*R2)/(R1 + R2);

% -- Voltage calibration plots
plot(P,Va,'Linewidth',1.5)
    hold on
plot(P,Vb,'Linewidth',1.5)
    hold on
    grid on
    xlim([-5 5])
    ylim([0 5])
    xlabel('Pressure (inches H_2O)')
    ylabel('Voltage Output (Volts)')
    title('Voltage Output of Two Devices vs. Measured Pressure')
    
% -- Voltge at specified positions
V = Vb(1,4:8);
P2 = -2:2;
plot(P2,V,'ko','Linewidth',1.5)
    hold on
    legend('Pressure Gauge Voltage output (V_a)','MSP Voltage input (V_b)','Pressure at selected points')
poly = polyfit(P,Vb,1);
    
    % In inches H2O
slope = poly(1);
fprintf('The value of the slope is %3.3f (V/In-H2O) \n',slope)

    % In Pascals
slope = slope / 249;
fprintf('The value of the slope is %3.5f V/Pa \n',slope)

    
    
    
    
