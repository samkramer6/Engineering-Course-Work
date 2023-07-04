%% Logistic growth map
    %This code is meant to simulate the logistic growth map and the
    %behavior that it exemplifies. The deliverables are 1 plot that
    %describes Population vs. time, the second deliverable is the
    %Population vs. rate.
    %
    %Xn+1 = r*Xn*(1-Xn)
    
%% Population vs. Time
%Testing 2 different R values where r = 2.6 and 0.5
%This equation only holds for the values of population > 1;
clear; clc; format compact; close all;
%parameters
X0 = 0.8;t = linspace(0,99); r = [2.6; .5];
X = zeros(100,1);
X(1) = X0;
%calculation for R = 2.60
for i = 1:(length(X) - 1)
    X(i+1) = r(1)*X(i)*(1-X(i)); 
end   
plot(t,X)
hold on;
converge1 = X(15);

%calculation for R = 0.5
for i = 1:(length(X) - 1)
    X(i+1) = r(2)*X(i)*(1-X(i)); 
end
plot(t,X)
hold on;
converge2 = X(15);

%Setup the graph
grid on;
ylim([0 1]);
xlim([0 15]);
title('The population vs. time of a Logistic Growth map');
xlabel('Time');
ylabel('Population');
legends = compose('r = %3.3f', r);
legend(legends);
fprintf('The initial population is %3.3f.\n', X0);
fprintf('The steady state population when r = 2.6 is %3.5f. \n', converge1);
fprintf('The steady state population when r = 0.5 is %3.5f. \n', converge2);

%% Population vs. Rate 
% Bifurcation Diagram example
%Testing the values of R and what effect that they have on the population
%These will print on a new graph
%parameters
r = 1:.001:5; P0 = 0.6; P = zeros(length(r),1); P(1) = P0; 
for i = 1:(length(r) - 1)
        P(i+1) = r(i)*P(i)*(1-P(i));
end
plot(r,P,'.');
ylim([0 1]);
xline(3.25);
xlabel('R values');
ylabel('Population');
grid on;

%% Transcritical Bifurcation
%This is another way that we can make the Bifurcation diagram using ODEs
%This will attempt to do the same thing as the previous section
%dP/dt = rx-rx^2
%parameters
r = 3;
dPdt = @(t,P) r*P*(1-P);
[t,P] = ode45(dPdt, [0 8], .6);
plot(t,P);