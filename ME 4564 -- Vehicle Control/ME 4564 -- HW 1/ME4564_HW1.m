%% ME 4564                                                      27 Aug 2022
% samkramer6                                                    Homework 1
% This is the script that will be used to complete the homework assignment
% problems
% Will return: 
%               1. A cornering stiffness calculation for problem 1a)
%               2. A plot of cornering force characteristics for problem
%                  1b)

%% Problem 1
% Initialize
clear; clc; format compact; close all;

% Parameters
% System parameters
wheelLoads = [9 14.5 28.5 38.5 52.5]; % Wheel Load Vector
slipAngle = [0:1:11];                 % Slip angle of wheel vector
corneringForce = [0 0 0 0 0;          % Cornering force Matrix Fc
    1 1.8 3.1 3.8 4;
    2.1 3.5 6.5 7.6 9.0;
    3.5 5.4 10 11.6 13.5;
    4.5 7.2 12.4 15.5 17.6;
    5.4 8.8 15 18.6 21.9;
    6.2 10.3 16.8 21.4 25.2;
    6.8 11.2 18.1 23.6 27.6;
    7.1 12 19.5 25.2 30;
    7.5 12.7 20.4 26.1 31.3;
    7.7 13.2 21 26.9 32.2;
    7.8 13.5 21.1 27.1 33.0;];

% Find the derivative of the lateral force vs. slip angle graph at zero
    % degree slip. This will be used to estimate the Ca at \alpha = 0
deri = diff(corneringForce(1:2,:)) ./ diff(slipAngle(1:2));


% Plot
for i = 1:length(wheelLoads)
    plot(slipAngle,corneringForce,'o-')
end

hold on

for i = 1:length(wheelLoads)
    f = @(x) deri(i)*x;
    fplot(f, [0 7])
end

% Format Plot
ylabel('Cornering Force (kN)')
xlabel('Slip Angle \alpha (^o)')
grid on
title('Cornering Force Characteristics with Cornering stiffness lines')
legend('Load 1','Load 2','Load 3', 'Load 4', 'Load 5','C_\alpha load 1',...
    'C_\alpha load 2', 'C_\alpha load 3','C_\alpha load 4',...
    'C_\alpha load 5')
xlim([0 11])
fprintf('the cornering stiffnesses (kN/deg) are: \n')
disp(deri)


                 
