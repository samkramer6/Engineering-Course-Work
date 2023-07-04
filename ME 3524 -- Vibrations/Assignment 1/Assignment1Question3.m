%% Assignment 1 question 3 
%This is the work for the first assignment specifically assignment 1
%question 3
%% Part B) and C)
clear; clc; close all; format compact;
%parameters
tVec = (0:0.01:600);IC = [1;0]; w = 1;
%declaration of the function
    %x'' + x' + 16x = 0
    %dx/dt = v
    %dv/dt = - 16x - v
diffeq = @(t,xv) [xv(2);
                   - 16*xv(1)];
%solving for the response now
[t,xv] = ode45(diffeq, tVec, IC);
%plotting the response
plot(xv(:,1))
hold on;
ylabel('X displacement of the response (m)');
xlabel('Time(s)');
grid on;
title('response to system in question 3');
%Printing the max amplitude of steady state function
steadyState = max(xv(:,1));
fprintf("The max displacement of the steady state vector is %3.3f m \n", steadyState);
legend('Response to system');

%% Part D)
clear;clc;format compact; close all;
%parameters
tVec = (0:60);IC = [0;0]; steadyState = zeros(91,1);
%declaration of the function
    %x'' + x' + 16x = 0
    %dx/dt = v
    %dv/dt = - 16x - v
%for-loop to solve for multiple w
w = 1:.1:10;
for a = 1:1:length(w)
%declare the function
diffeq = @(t,xv) [xv(2);
                   -xv(2) - 16*xv(1) + sin(w(a)*t)];
%solve for the function 
[t,xv] = ode45(diffeq, tVec, IC);
%plot the response
plot(xv(:,1))
hold on;
steadyState(a) = max(xv(:,1));
a = a + 1;
end
ylabel('X displacement of the response (m)');
xlabel('Time(s)');
grid on;
title('response to system in question 3');
%creation of Table
string = compose('Omega = %3.2f',1:.1:10);
tab = table(steadyState,'VariableNames',{'Max Deflection'},'RowNames',string);
disp(tab);
%Plot part C) on top of the graph
diffeq = @(t,xv) [xv(2);
                   -xv(2) - 16*xv(1) + sin(t)];
[t,xv] = ode45(diffeq, tVec, IC);
plot(xv(:,1),'linewidth',2)
