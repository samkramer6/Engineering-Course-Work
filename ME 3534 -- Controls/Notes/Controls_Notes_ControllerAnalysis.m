%% ME3534 Lecture Notes                                Sam Kramer   3/22/22
%   These are the lecture notes on Z-N PID compensator Design
%   Will Return:
%                   1. Graph showing Unit Step Response
%                   2. The responses of Different types of compensators
%

% -- Setup
clear;clc;format compact; close all;

%  --define the time vector
fs = 200;
ts = 1/fs;
tfinal = 8;
N = round(tfinal/ts);
t = ts * [0:N-1];

%  --define the plant transfer function
P = tf([1],poly([-1 -3 -5]));

%  --determine the Z-N critical gain
C = 192;
L = C * P;
CL = minreal(L / (1 + L));
[y,t] = step(CL,t);

%  --plot the results
plot(t,y)
grid on
xlabel('Time (sec)')
ylabel('Step Response')
title(['K_P = num2str(C) K_I = 0,   K_D = 0'])

%  --compute the Z-N gains
Kc = 192;  Tc = 1.31;
Kp = Kc * [0.5 0.45 0.8 0.6 0.7 0.33 0.2];
Ti = Tc * [inf 1/1.2 inf 1/2 1/2.5 1/2 1/2];
Td = Tc * [0 0 1/8 1/8 3/20 1/3 1/3];

%  --evaluate and plot the step responses
Y = zeros(N,7);
figure

for i = 1:7
num = Kp(i) * [Td(i), 1, 1/Ti(i)];
C = minreal(tf(num,[0 1 0]));
L = C * P;   
CL = minreal(L / (1 + L))  % Cancels zero pole ("Help minreal") for more
[y,t] = step(CL,t);              
Y(:,i) = y;
end

%  --plot the results
legend_labels = {'P','PI','PD','Classic PID','Pessen','Some Overshoot','No Overshoot'}; 
plot(t,Y,'Linewidth',1.5)
grid on
xlabel('Time (sec)')
ylabel('Response y(t)')
legend(legend_labels)
title('Different Types of Responses for different Controllers')

