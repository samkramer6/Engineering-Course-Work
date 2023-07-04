%% ME 4564: Vehicle Control Project 2                           
% Uses the bicycle dynamics model of a vehicle to calculate lateral
% velocity and yaw rate given front and rear axle lateral forces, lateral
% forces given slip rates for front and rear, and finally a section that
% calculates slip angle at the front and rear given vehicle geometry
%
% Sam Kramer                                                     11/06/2022
% 
% Will Return:
%               1. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part 3: Calculating slip angle given vehicle geomety and velocities
    % Working backwards is easier to calculate the needed values

% --Setup 
clear; clc; format compact; close all;

% --Vehicle Parameters
    U = 10.43843;       % Mean velocity (m/s)
    m = 1031;           % Mass of vehicle (kg)
    Iz = 1886;          % Yaw moment of inertia (kg.m^2)
    Lf = 0.927;         % Font axle to CoG (m)
    Lr = 1.56;          % Rear axle to CoG (m)
    d_f = 5;            % Front steering angle of front wheel (degrees)
    
% --Calculate Fz
    % 60/40 distribution of the vehicle
    weight = m*9.81;    % Weight of vehicle (N)
    Fz = weight/1000;   % Weight of vehicle (kN)
    Fzf = (Fz*.6)/2;    % Weight on one front wheel (kN)
    Fzr = (Fz*.4)/2;    % Weight on one rear wheel (kN)
    
% --Import Pacejka Coefficients
    cfs = readmatrix('P2.xlsx');
    a = cfs(1:18,2);    % First tire lateral coefficients
    
% --Calculate cornering stiffness
    Caf = a(4)*sin( 2*atan(Fzf/a(5)) );     % Front cornering stiffness
    Car = a(4)*sin( 2*atan(Fzr/a(5)) );     % Rear cornering stiffness
    
% --   
    




