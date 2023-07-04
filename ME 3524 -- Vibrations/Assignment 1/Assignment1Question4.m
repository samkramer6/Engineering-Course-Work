%% Assignment 1 Question 4
%This is the work for the fourth question in homework number 1

%% Part B)
clear; clc; format compact; close all;
%parameters
IC = [0,0]; t_interval = (0:.1:10);
%define function
    %x'' + x' + 16x = sin(3t) + cos(7t)
        %dx/dt = v
        %dv/dt = sin(3t) + cos(7t) - 16x - v
diffEq = @(t,xv) [xv(2);
                    sin(3*t) + cos(7*t) - 16*xv(1) - xv(2)];
%solve the equation to find the response
[t,xv] = ode45(diffEq, t_interval, IC);
plot(t,xv(:,1),'LineWidth',1.5);
grid on;
title('Response to the system');
xlabel('Time (s)');
ylabel('Amplitude (m)');
legend('Response to system');

%% Part c)

clear; clc; format compact; close all;
%parameters
IC = [0,0]; t_interval = (0:.1:100);
%define function
    %x'' + x' + 16x = sin(3t) + cos(7t)
        %dx/dt = v
        %dv/dt = sin(3t) + cos(7t) - 16x - v
diffEq = @(t,xv) [xv(2);
                    sin(3*t) + cos(7*t) - 16*xv(1) - 3.58*xv(2)];
%solve the equation to find the response
[t,xv] = ode45(diffEq, t_interval, IC);
%plot function
plot(t,xv(:,1),'LineWidth',1.5);
%set up the plot
grid on;
title('Response to the system');
xlabel('Time (s)');
ylabel('Amplitude (m)');
legend('Response to system');
maxDisp = max(xv(:,1));
%output deliveribles for question
fprintf('The damping coefficient that is required in order to reduce displacement to be below 0.1m is 3.58 \n');
fprintf('The maximum displacement to occurs with this damping coefficient is %3.5f.\n', maxDisp);

