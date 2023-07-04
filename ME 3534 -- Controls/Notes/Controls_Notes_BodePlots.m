%% ME 3534 Bode Plot Notes
% Sam Kramer                                                    14 Apr 2022
% This script will contain the notes on how to make a bode plot in three
% separate ways. 
%   1. ltiview() method is the first way and is an interactive tool that will
%      help view the different bode plot
%   2. bode() is the second method and is the stanard method
%   3. bodeplot() is the third method and is another standard method that
%      is similar to bode()
% 

% -- Setup
clc;clear; close all; format compact;

% -- Declaration of the transfer functions
    % G1 -- Gain function 
    T1 = tf(0.1,1);                         % LTI continuous gain

    % G2 -- First sinusoidal function
    w2 = 2*pi*0.1;                          % The frequency of G2
    T2 = tf([1 w2], [0 w2]);                % G2 function normalized
    
    % G3 -- Second sinusoidal function
    w3 = 2*pi*10;                           % Frequency of G3
    T3 = tf(w3*w3, [1 2 w3*w3, w3*w3]);     % G3 function normalized

    % G -- Overall transfer function
    T = T1 * T2 * T3;                       % Overall Transfer function

% -- Different methods used to plot graph

ltiview('bode',T1,T2,T3,T)  % This is the plot method 1

bode(T1,T2,T3,T)            % This is the plot method 2
    hold on
    grid on
    figure()

bodeplot(T1,T2,T3,T)        % This is the plot method 3
    hold on
    grid on 
    
