%% Controls Assigment Number 1
    % Problem 2 part b)
    % Plot the time dependent function derived in a)
    % y(t) = 2te^-t + e^-t
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Setup of question
clear; clc; format compact; close all;

% -- Parameters
t = linspace(0,10,200); % Time vector that will be used in the graph
yt = (t - 1)+ 2*exp(-t) + t.*exp(-t); % The time dependent equation of equation

% -- Plot Equation
plot(t,yt);
    hold on;
    grid on;
    title('Graph of the Displacement of Given Equation of Motion')
    xlabel('Time (s)')
    ylabel('Displacement')
 
% -- Check Answer vs. analytical method
f = @(t,xv) [xv(2);
             (t + 1) - 2*xv(2) - xv(1)]; % Creation of the function
[t,xv] = ode45(f,[0 10],[1 0]); % ODE45 Solver
x = xv(:,1);

% -- Plotting Numerical Method
plot(t,x,'*r')
    hold on;
    legend('Analytical method','Numerical Computer Method')
    
    