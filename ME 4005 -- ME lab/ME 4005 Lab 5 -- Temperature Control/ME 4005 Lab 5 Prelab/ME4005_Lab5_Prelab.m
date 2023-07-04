%% ME 4005 Prelab

% -- Setup
clear; clc; format compact; close all;

% -- Load in data
Tss = load('ME4005_Lab5_TssData');
Th = load('ME4005_Lab5_hData');

% -- Resize Vectors
tss = Tss.t;
qppss = Tss.v1;
TC1ss = Tss.v2;
TC2ss = Tss.v3;

th = Th.t;
qpph = Th.v1;
TC1h = Th.v2;
TC2h = Th.v3;

% -- Generate Plots for each
    % Tss subplots
    
    subplot(3,1,1)      % Steady state heat flux sensor data
        plot(tss,qppss,'color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        ylabel('Heat Flux (W/m^2)','FontSize',12)
        grid on
        hold on
        ylim([-10 10])
        xlim([0 max(tss)])
        title('Experimental Steady State Values vs. Time')
        
    subplot(3,1,2)      % Steady state thermocouple 1 data    
        plot(tss,TC1ss,'color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        hold on
        grid on
        ylabel('Temperature (^oC)','FontSize',12)
        ylim([0 20])
        xlim([0 max(tss)])
    
    subplot(3,1,3)      % Steady state thermocouple 2 data
        plot(tss,TC2ss,'color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        grid on
        hold on
        xlabel('Time (s)','FontSize',12)
        ylabel('Temperature (^oC)','FontSize',12)
        ylim([0 30])
        xlim([0 max(tss)])
        
    % Heated Subplots
        
    figure(2)    
    subplot(3,1,1)      % Heated heat flux sensor data
        plot(th,qpph,'color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        ylabel('Heat Flux (W/m^2)','FontSize',12)
        grid on
        hold on
        ylim([-10 50])
        xlim([0 max(th)])
        title('Experimental Steady State Values vs. Time')
        
    subplot(3,1,2)      % Heated thermocouple 1 data
        plot(th,TC1h,'color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        hold on
        grid on
        ylabel('Temperature (^oC)','FontSize',12)
        ylim([14 18])
        xlim([0 max(th)])
    
    subplot(3,1,3)      % Heated thermocouple 2 data
        plot(th,TC2h,'color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        grid on
        hold on
        xlabel('Time (s)','FontSize',12)
        ylabel('Temperature (^oC)','FontSize',12)
        ylim([14 18])
        xlim([0 max(th)])
        
% -- Calculating the variance and std deviation of ss data
    % Steady state data

    stdQppss = std(qppss); % Standard deviation calculations
    stdTC1ss = std(TC1ss);
    stdTC2ss = std(TC2ss);
    StandardDeviation = [stdQppss;stdTC1ss;stdTC2ss];
    
    varQppss = var(qppss);  % Variance calculations
    varTC1ss = var(TC1ss);
    varTC2ss = var(TC2ss);
    Variance = [varQppss;varTC1ss;varTC2ss];

% -- Min and max of the heated data
    % Max
    maxTC1h = max(TC1h);
    maxTC2h = max(TC2h);
    maxQpph = max(qpph);
    Maximums = [maxQpph; maxTC1h; maxTC2h];
    
    % Min
    minTC1h = min(TC1h);
    minTC2h = min(TC2h);
    minQpph = min(qpph);
    Minimums = [minQpph; minTC1h; minTC2h];
    
    % Differences
    diffTC1 = maxTC1h - minTC1h;
    diffTC2 = maxTC2h - minTC2h;
    diffQpph = maxQpph - minQpph;
    Differences = [diffQpph; diffTC1; diffTC2];
    
   
% -- Table for data

Names = ["Heat Flux";"Thermocouple 1"; "Thermocouple 2"];
Table = table(Names, Minimums, Maximums,Differences,Variance,StandardDeviation);
fprintf('The data for maxium and minimum values are below: \n')
disp(Table)

% -- Estimating time constants

    % Rise and fall vector data
    rise = find((th>=35.1) & (th <= 121));
    fall = find((th>= 121.1) & (th <= 200));
    
    trise = th(rise);
    TCrise = TC2h(rise);
    
    tfall = th(fall);
    TCfall = TC2h(fall);
    
    % Plot results
    
    figure(3)
    plot(trise,TCrise)
        hold on
    plot(tfall,TCfall)
        hold on
        grid on
    
 % -- Curve fitting
   
    fittedexp = @(p,t) (p(1) *exp(-(t-t(1))/p(2)) + p(3));
    
    % Define initial guess for parameters
    tau0 = 1; % Initial guess
    p0rise = [(TCrise(1)-TCrise(end)), tau0, TCrise(end)];
    p0fall = [(TCfall(1)-TCfall(end)), tau0, TCfall(end)];
    
    % Search for the optimal parameters
    pfall = fminsearch(@(p) norm(TCfall - fittedexp(p,tfall)), p0fall);
    prise = fminsearch(@(p) norm(TCrise - fittedexp(p,trise)), p0rise);
    
    %  Compute the estimated exponential
    TCrise_fit = fittedexp(prise,trise);
    TCfall_fit = fittedexp(pfall,tfall);
    
    plot(trise,TCrise_fit)
        hold on
    plot(tfall,TCfall_fit,'k')
        hold on
  
fprintf('The time constant tau = %3.3f.\n',tau0)
    title('Measured Temperature Response vs. Theoretical Temperature Response','FontSize',10)
    xlabel('Time (s)','FontSize',10)
    ylabel('Temperature (^oC)','FontSize',10)
    legendVector = ["Experimental Rise Temp";"Experimental Fall Temp";"Theoretical Rise";"Theoretical Fall"];
    legend(legendVector,'FontSize',9);
    


    
 
 
 
 
 
 
 
 
 
 
        
        