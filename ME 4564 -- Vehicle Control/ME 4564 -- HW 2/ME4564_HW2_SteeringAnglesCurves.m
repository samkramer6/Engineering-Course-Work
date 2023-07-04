%% ME 4564 Homework #2 Problem 4
% This script will be the work that will generate a smooth plot showing how
% the required steering angle changes versus velocity using a set of given
% parameters.
%   Will Return:
%               1. A graph showing steering angle versus velocity

% --Setup
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Work %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    wt = 1.5;                   % Vehicle track width (m)
    L = 2.3;                    % Vehicle wheel base (m)
    m = 2000;                   % Mass of vehicle (kg)
    front_dist = 0.60;          % Front vehicle distribution
    rear_dist = 0.40;           % Rear vehicle distribution
    C_alpha = 90000;            % Wheel cornering stiffness (N/rad)
    r = 75;                     % Turn radius (m)
    u = [0:0.1:40];             % Vehicle velocity (m/s)

% --Calculating a, b, Ri, and Ro
    
    % --Calculating a and b
        a = L*(1 - front_dist);     % Calculating a length of CoG
        b = L*(1 - rear_dist);      % Calculating b length to CoG
        
    % --Calculating Ri and Ro
        Ri = r;                     % Calculating inner wheel turn radius
        Ro = r + wt/2;              % Calculating outer wheel turn radius
        
% --Innter Tire
    Di = (L/Ri) + ((b - a)/C_alpha).*((m.*(u.^2))/(L*Ri));
        plot(u,Di,'LineWidth',1);
            hold on
        
% --Outer Tire
    Do = (L/Ro) + ((b - a)/C_alpha).*((m.*(u.^2))/(L*Ro));
        plot(u,Do,'LineWidth',1);
            hold on

% --Setup plot
    grid on
    xlabel('Velocity (m/s)');
    ylabel('\delta Steering Angle (radians)');
    title('Plot of steering angle change vs. velocity of vehicle');
    lgd = legend('Inner Tire \delta','Outer Tire \delta');
    lgd.Location = 'NorthWest';

% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%