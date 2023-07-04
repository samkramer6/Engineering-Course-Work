%% Controls Notes on Type Number Analysis
% 2/24/2022
% Samuel Kramer
% Learning how to compare the error over time of two separate closed loop
% transfer functions where:
%   Plant : P(s) = (s + 7)/( (s^2)(s + 19))
%   C(s)1 = K
%   C(s)2 = K/s
%   L = P(s) * C(s)     (Open Loop TF)
% 
% Will Return:
%       1.  Graph of response vs. time using the CL TF to see the position
%           vs. the time
%       2.  Graph of the error vs. time using the OL TF to see the error
%           comparison between the two systems

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Example %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc; format compact;t = linspace(0,8,1000);

% -- Initialization of the two transfer fnctions

P = tf([1 7],[1 19 0]); % Plant Definition
C1 = 15;                % Proportional Control
C2 = tf(1000,[1 0]);    % Integral Control

L1 = P * C1;            % Open Loop Transfer Functions
L2 = P * C2;

CL1 = (L1 / (1 + L1));  % Total Closed Loop Transfer Function
CL2 = (L2 / (1 + L2));

r = ones(size(t));
k = find(t<0.5);
r(k) = zeros(1,length(k));
k = find(t>=3.5 & t<=6);
r(k) = linspace(1,0,length(k));
k = find(t>=6);
r(k) = zeros(1,length(k));
y1 = lsim(CL1,r,t)';
y2 = lsim(CL2,r,t)';

figure

 % -- Subplot 1: Response of System vs. Time
 
subplot(2,1,1);
plot(t,r,'r',t,y1,'b',t,y2,'g--')
    grid on
    xlabel('Time (sec)')
    ylabel('Response y(t)')
    ylim([-0.2,1.8])
    legend('Reference','Proportional Control', ...
    'Integral Control')
    set(gca,'LooseInset',get(gca,'TightInset'))

% -- Subplot 2: Error of System vs. Time

subplot(2,1,2);
plot(t,r-y1,'b',t,r-y2,'g--')
    grid on
    xlabel('Time (sec)')
    ylabel('Error e(t)')
    ylim([-1,1])
    legend('Proportional Control','Integral Control')


