%% ME 3534 Homework #2
% This script is the MATLAB solution to the selected problems
%
% Samuel Kramer
% 2/23/2022

%% Question 2 Part b)
% Plotting the responses of a unit step, unit ramp, and unit impulse on a
% time response graph
%
% Block Diagram: 
% R(s) ---> P(s) ---> C(s) = R(s) * P(s)
% P(s) = 10 / (S^2 + 2s + 10)
% 
% C(s) = (10 * R(s)) / (S^2 + 2S + 10)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Unit Step %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unit Step R(s) = 1/S

% -- Parameters

clear;clc;format compact; close all;syms s;t = [0:0.1:7];

% -- Creation of The Time dependent function

num1 = 10; denom1 =  s^2 + 2*s + 10; % Plant TF
Ps = num1 / denom1; 

num2 = 1; denom2 = s;   % Input TF
Rs = num2/denom2; 

Cs = Ps * Rs   % Total Transfer Function

system = ilaplace(Cs)  % Inverse Laplace to find time dependent function

% -- Plotting the Function

H = matlabFunction(system); % matlabFunction changes sym to anon function
plot(t,H(t),'Linewidth',1.5); % Plotting the anon function
    hold on
    grid on
    xlabel('Time (s)')
    ylabel('Position')
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Unit Ramp Response %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unit Ramp R(s) = 1/S^2

% -- Creation of Time Dependent Function

num2 = 1; denom2 = s^2; Rs = num2/denom2; % Redefine of R(s)
Cs = Ps*Rs; % Redefine Imaginary Response
system = ilaplace(Cs); % Find Inverse Laplace

% -- Plotting Function

H = matlabFunction(system);
plot(t,H(t),'Linewidth', 1.5);
    hold on
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Unit Impulse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unit Impulse R(s) = 1

% -- Initialization of Time Dependent Function

Cs = Ps; % Initialization of the TF
system = ilaplace(Cs); % Inverse Laplace to find time dependent function

% -- Plot Function

H = matlabFunction(system);
plot(t, H(t),'Linewidth',1.5);
    hold on;
    xlabel('Time (s)');
    ylabel('Position');
    title('System Response as a Function of Time');
    legend('Unit Step Response','Unit Ramp Response','Unit Impulse Response');
    
%% Question 3
% Plot the Time domain solution to the transfer function, find the Rise
% Time, Peak Time, Max Overshoot, and Settling Time
% 
% TF = 36 / (s^2 + 2*s + 36)
% C(s) = (R(s) * 36 )/ (s^2 + 2*s + 36)
%
% r(t) = 1 ---> R(s) = 1/s

% -- Parameters

clear; clc; format compact; close all; syms s; t = [0:.01:7];
wn = 6; z = 1/6;

%%%%%%%%%%%%%%%%%%%%%%%%%% Time Domain Response %%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Initialization of the TF

num1 = 36; denom1 = s^2 + 2*s + 36; Ps = num1/denom1;
num2 = 1; denom2 = s; Rs = num2/denom2;
Cs = Ps*Rs;

system = ilaplace(Cs);

% -- Plotting Function

H = matlabFunction(system);
plot(t,H(t));
    grid on;
    hold on;
    title('Time Domain Response to a Unit Step Input');
    xlabel('Time (s)')
    ylabel('Position');
    ylim([0 2]);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Performance Metrics %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Transfer Function Setup

num = [0 0 wn^2]; denom = [1 2*z*wn wn^2];
sys = tf(num,denom);
Y = step(sys,t);
info = stepinfo(Y,t);

% -- Plotting the lines where the performance metrics are
yline(info.Peak)
xline(info.PeakTime,'r')
xline(0.2938,'g')
xline(info.SettlingTime,'c')
legend('Response to Unit Step Input','Peak Location','Peak Time','Rise Time','Settling Time');




