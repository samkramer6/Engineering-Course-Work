%% Solving for a Multi Degree of Freedom System
%Initial Parameters
clear; clc; close all;
M1 = 5000; M2 = 4000; M3 = 4000; M4 = 1000;
K1 = 7000; K2 = 5000; K3 = 5000; K4 = 2500;
% Equation of Motion
    %M[X''] +K[X] = 0
M = [M1 0 0 0;
     0 M2 0 0;
     0 0 M3 0;
     0 0 0 M4];
K = [K1+K2 -K2 0 0;
     -K2 K2+K3 -K3 0;
     0 -K3 K3+K4 -K4;
     0 0 -K4 K4];
 
%Answer solutions
    %X'' = (-K/M) *X
    %In this section we are calculating the different variables X and V for
    %the system. The matrix A calculates the the K/M * X values that will
    %be used for solution. 8x8 because we must calculate for all of the
    %displacement values but also the velocity values.
A = [zeros(4) eye(4); -inv(M)*K zeros(4)];

%This is the total equation that we will be solving for that is in the form
%of X'' = (-K/M)*X. the X(1:8) is necessary because there are 8 equations
%we must solve for 4x Displacement and 4x velocity.
Xdot = @(t,X) A*X(1:8); 

Initials = [0.001 0.010 0.020 0.025 0 0 0 0];
tspan = [0:0.01:20];

%Solving using ODE45 as such
[t, values] = ode45(Xdot, tspan, Initials);
X1 = values(:,1);
X2 = values(:,2);
X3 = values(:,3);
X4 = values(:,4);

%Subplot plotting to see analysis
subplot(4,1,1);
plot(t, X1,'linewidth', 1.5);
hold on;
title('MDOF System Mass 1; Pos(x(t))');
ylabel('displacement (mm)');
grid on

subplot(4,1,2);
plot(t, X2,'linewidth', 1.5);
hold on;
title('MDOF System Mass 2; Pos(x(t))');
ylabel('displacement (mm)');
grid on

subplot(4,1,3);
plot(t, X3,'linewidth', 1.5);
hold on;
title('MDOF System Mass 3; Pos(x(t))');
ylabel('displacement (mm)');
grid on

subplot(4,1,4);
plot(t, X4,'linewidth', 1.5);
hold on;
title('MDOF System Mass 4; Pos(x(t))');
xlabel('time (s)');
ylabel('displacement (mm)');
grid on



