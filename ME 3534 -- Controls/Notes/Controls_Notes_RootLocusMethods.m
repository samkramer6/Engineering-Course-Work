%% ME 3534 Notes on Root Locus
% Sam Kramer                                                    29 March 22
% These are notes regarding how to accurately plot root locus for analysis

% -- Setup
clear;clc;format compact; close all

% -- Method one
    % This is the quick method and does not offer alot of flexibility with
    % the setup of the figures created.
    
    % Definition of OLTF numerator and denominator
    Z = [-7];
    P = [ 0 -5 -15 -20];

    % Creation of the transfer function
    Gs = zpk(Z,P,1);

    % rlocus() command is used to graph root locus of the system
    rlocus(Gs)

    % Setup of figure 1
    sgrid
    ylim([-20 20])
    xlim([-40 0])
    hold on
    set(gca,'yaxislocation','right')
    figure(2)
    

% -- Method two
    % This is the manual version of what is done above
        % This allows for more flexibility with how the graph looks in terms of
        % formatting of the axes
        
[R,K] = rlocus(Gs);
ms = 10;
c = get(0,'defaultaxescolororder');

for i = 1:length(Z)
    plot(real(Z(i)),imag(Z(i)),'color',c(i,:),'marker','o','markersize',ms)
    hold on
end

for i = 1:length(P)
plot(real(P(i)),imag(P(i)),'color',c(i,:),'marker','x','markersize',ms)
end

for i = 1:length(P)
plot(real(R(i,:)),imag(R(i,:)),'color',c(i,:))
end

sgrid([0:0.1:1],[5:5:35])
xlim([-32,2])
ylim(20*[-1,1])
set(gca,'yaxislocation','right')
xlabel('Real(s)')
ylabel('Imag(s)')
title('Root Locus')