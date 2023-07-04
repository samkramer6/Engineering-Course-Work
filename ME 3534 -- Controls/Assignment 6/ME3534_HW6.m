%% ME 3534 Homework #6 
% Sam Kramer                                                    18 APR 2022
% This is the work for homework number 6 on Bode Plots and Root Locus

%% Problem 2
% Find the root loci of the system and plot the reponse to a step input
% Schematic of open loop transfer function
%                          K
%            G(s) = ---------------
%                   s(s^2 + 4s + 5)
% Will return: 1 graph of the root locus and the response to a setp input

% -- Setup
clc; clear; format compact; close all;syms s;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% work %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Root locus analysis
Z = [];                     % Zeros Vector  
P = [0 -2+1*i -2-1*i];      % Poles Vector
Gs = zpk(Z,P,1);            % Definition of the OL tranfer function
rlocus(Gs);                 % Plotting root loci
    sgrid
    ylim([-5 5])
    xlim([-5 0])
    hold on
    set(gca,'yaxislocation','right')
    figure(2)
    
% -- Step function response
    % The step input will have the R(s) = 1/s
K = 4.3;    % We chose 4.3 to be the maximum gain from hand work
num = [K];
denom = [1 4 5 0];
Gs = tf(num,denom);
Hs = minreal(Gs / (1 + Gs));    % This will define the CLTF
step(Hs)                        % Will plot a response to a step function
    grid on;
    hold on;
    xlabel('Time')
    ylabel('Displacement')
    title('System Response to a Step Input vs. Time');
    
%% Problem 5
% Plot the bode diagrams of G1(s) and G2(s)
% Schematics of open loop transfer function
%                     1 + s               1 - s
%            G1(s) = --------   G2(s) = ---------
%                     1 + 2s              1 + 2s
% Will return: Two independent subplots with bode plots 

% -- Setup
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Work %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Define transfer functions
num1 = [1 1];   
num2 = [-1 1];
denom = [2 1];          % Denominator is shared between both

G1 = tf(num1,denom);    % Open loop transfer function 1
G2 = tf(num2,denom);    % Open loop transfer function 2

% -- Setup bode plot options
opts = bodeoptions('cstprefs');
    opts.FreqUnits = 'Hz';
    
% -- Output bode plots
    % Plot G1
opts.Title.String = 'Bode Plot of G1';
bode(G1,opts);
    hold on
    grid on
    figure
    
    % Plot G2
opts.Title.String = 'Bode Plot of G2';
bode(G2,opts)
    hold on
    grid on
    
%% Problem 6
% Plot the Bode diagram of the Open Loop Transfer Function G(s)
%                     10(s^2 + 0.4s + 1)             
%            G1(s) = --------------------  
%                     s(s^2 + 0.8s + 9)
% Will return: 1 bode subplot with phase and magnitude

% -- Setup
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Work %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Define transfer function
num = [10 4 10];
denom = [1 0.8 9 0];

Gs = tf(num,denom);         % Definition of transfer function

% -- Bode options setup
opts = bodeoptions('cstprefs');
    opts.FreqUnits = 'Hz';

% -- Output bode plots
opts.Title.String = 'Bode Plot of G(s) vs. Frequency (Hz)';
bode(Gs,opts)
    grid on
    hold on
    
    
















 