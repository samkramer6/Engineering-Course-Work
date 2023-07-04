%% ME 5714: Homework #3 Work
%   
%   [Documentation]
% 
%   Sam Kramer
%   Feb 19th, 2023

% --Setup
    clear; clc; format compact; close all;
    
% --Parameters
    t =  0:.001:8000 ;                 % Time vector (s)
    T0 = 1000;                                      % Sphere Temp (K)
    Ta = 300;                                       % Ambient Temp (K)
    scale = [1*10^-9, 1*10^-6, 1];                  % Scale vectors (m)
    k = 148;                                        % Cond coeff (W/m-K)
    rho = 2330;                                     % Density (kg/m^3)
    cp = 712;                                       % Specific heat (j/g-K)
    kappa = k/(rho*cp);                             % ND parameter
    r = 0.0001;
    
% --For loop
    for i = 1:length(scale)
        
        % --Loop setup
            a = scale(i);
            summation_term = 0;
            
        % --Summation loop
            for n = 1:11
                
                % --Calculate nth term
                    term_n = (((-1)^n)/n)*exp((-kappa*(n^2)*(pi^2).*t)/(a^2)) * (n*pi/a);
                    summation_term = summation_term + term_n;

            end

            Trt = Ta - (2*a*(T0 - Ta) / pi)*(summation_term);
            
        % --Plot value
            figure(1)
            subplot(3,1,i)
            plot(t,Trt,'LineWidth',1.5)
                hold on
                grid on
    end
    
% --Format plots
    subplot(3,1,1)
        xlim([0 .1])
        subtitle('a = 1 nm')
        title('Temperature of Center of Silicon Sphere as a Function of Time')
        legend('\kappa = 8.9*10^{-9}')
        
    subplot(3,1,2)
        xlim([0 .1])
        ylabel('Temperature (K)')
        subtitle('a = 1 \mum')
        
    subplot(3,1,3)
        %xlim([0 400])
        xlabel('Time (s)')
        subtitle('a = 1 m')
        yline(300,'LineWidth',1)
 

%% 
% --Table of when they reach their minimum temperatures
    values = [6.96*10^-15, 7*10^-9, 6.97*10^-7, 6.96*10^-5, 0.697, 6966]';
    size = {"1 nanometer", "1 micrometer", "10 micrometers", "100 micrometers", "1 cm", "1 m"}';
    t = table(size,values);
    disp(t)
    
% --plot on log/log plot
    scales = [1*10^-9, 1*10^-6, 10*10^-6, 100*10^-6, .01,  1];
    figure(2)
    loglog(scales,values,'LineWidth',1.5);
        xlabel('Scale (m)')
        ylabel('Cooling Time (m)')
        grid on
        hold on
        title('log-log Plot of Cooling Time vs. Scale')
        
        