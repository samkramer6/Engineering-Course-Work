%% ME 4005 Lab 5 Data Processing
% Sam Kramer                                                   9 April 2022
% This is the data processing file for the data collected from lab 5. This
% will be split into two separate parts, one associated with the first
% manual data collection and the second with the automatic control of the
% temperature.
% Will Return:
%               1. Graphs of the data for each experiment
%               2. The mean, error, and OS of each control experiment

% -- Setup
clear; clc; close all; format compact;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This section will analyze the manual control data from the lab

% -- Load in data
manual = load('Manual_Control');
P_Controller = load('Kp175');
I_Controller = load('Ki3_5');
PI_Controller = load('Kp175_Ki3_5');

% -- Resize data matrix for manual control portion of lab
mT1 = manual.v2;
t = manual.t;

% -- Plotting data 
plot(t,mT1,'Linewidth',1.5) % Plots data from manual controller experiment
    grid on
    hold on
    xlabel('Time (s)')
    ylabel('Temperature (^oC)')
    title('Temperature with Manual Control of Heater vs. Time')
    yline(20,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
    xlim([0 max(t)])
    
% -- Resize mT1 data vector to accurately find data
mT1 = mT1(1,145:length(mT1));
    
% -- Finding controller performance metrics
Tavg = mean(mT1);
ess1 = Tavg - 20;       % Because here 20 is the desired temperature
OS1 = max(mT1) - 20;

% -- Output all the metrics
fprintf('The mean value of the manual control experiment is %3.3f Celcius.\n',Tavg)
fprintf('The steady state error of the manual experiment is %3.3f Celcius.\n',ess1)
fprintf('The overshoot of the manual control experiment is %3.3f Celcius.\n \n', OS1)

% -- Put on graph
yline(Tavg,'Color',[0.6740 0.4660 0.1880],'Linewidth',1.5)
text(25.0978,20.7082,'Maximum Overshoot of 0.708 Celcius')
plot(23.0978,20.7082,'x','Color',[0.6740 0.1660 0.1880],'Linewidth',2);
legend('Manual Control Data','Desired Setpoint','Average Temperature','Max Overshoot Point')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This part will analyze the data from the contoller part with a
% Proportional, Integral, and a PI controller used.

% -- Load in data

    % Proportional Controller Data
    pT1 = P_Controller.v2;
    pt = P_Controller.t;
    
    % Integral Controller Data
    iT1 = I_Controller.v2;
    it = I_Controller.t;
    
    % Proportional-Integral Controller Data
    piT1 = PI_Controller.v2;
    pit = PI_Controller.t;
    
% -- Plot all data

    % Proportional Controller Data
    figure(2)
    plot(pt,pT1,'Linewidth',1.5)
        hold on
        grid on
        xlabel('Time (s)')
        ylabel('Temperature (^oC)')
        title('Temperature with Proportional Controller vs. Time')
        yline(20,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        xlim([0 max(pt)])
        
    % Integral Controller Data   
    figure(3)
    plot(it,iT1,'Linewidth',1.5)
        hold on
        grid on
        xlabel('Time (s)')
        ylabel('Temperature (^oC)')
        title('Temperature with integral Controller vs. Time')
        yline(20,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        xlim([0 max(it)])
        
    % PI Controller Data
    figure(4)
    plot(pit,piT1,'Linewidth',1.5)
        hold on
        grid on
        xlabel('Time (s)')
        ylabel('Temperature (^oC)')
        title('Temperature with PI Controller vs. Time')
        yline(20,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
        xlim([0 max(pit)])

% -- Resize Data matrices
pT1 = pT1(1,144:length(pT1));
iT1 = iT1(1,140:length(iT1));
piT1 = piT1(1,188:length(piT1));
        
% -- Finding controller performance metrics

    % Proportional Controller
    TPavg = mean(pT1);
    essP = TPavg - 20;       % Because here 20 is the desired temperature
    OSP = max(pT1) - 20;
    
    % Integral Controller
    TIavg = mean(iT1);
    essI = TIavg - 20;       % Because here 20 is the desired temperature
    OSI = max(iT1) - 20;
    
    % PI Controller
    TPIavg = mean(piT1);
    essPI = TPIavg - 20;       % Because here 20 is the desired temperature
    OSPI = max(piT1) - 20;

% -- Output all the performance metrics

% Proportional Controller
fprintf('The mean value of the proportional controller is %3.3f Celcius.\n',TPavg)
fprintf('The steady state error of the proportional controller is %3.3f Celcius.\n',essP)
fprintf('The overshoot of the proportional controller is %3.3f Celcius.\n\n', OSP)

% Integral Controller
fprintf('The mean value of the integral controller is %3.3f Celcius.\n',TIavg)
fprintf('The steady state error of the integral controller is %3.3f Celcius.\n',essI)
fprintf('The overshoot of the integral controller is %3.3f Celcius.\n \n', OSI)

% PI Controller
fprintf('The mean value of the PI controller is %3.3f Celcius.\n',TPIavg)
fprintf('The steady state error of the PI controller is %3.3f Celcius.\n',essPI)
fprintf('The overshoot of the PI controller is %3.3f Celcius.\n \n', OSPI)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the section that will analyze the data for the disturbance
% rejection data that will be used in the lab report.

% -- Load data
disturbance = load('Disturbance');
    dT1 = disturbance.v2;
    dt = disturbance.t;
    
% -- Plot data
    figure(5)
    plot(dt,dT1,'Linewidth',1.5,'Color',[0.2660 0.3740 0.6880])
        grid on
        hold on
        yline(20,'Linewidth',1.5,'Color',[0.4660 0.6740 0.1880])
        plot(29.401,19.685,'rx','Linewidth',2)
        plot(69.0921,19.603,'rx','Linewidth',2)
        text(20,19.5,'Thermal Disturbance 1','fontsize',12)
        text(60,19.5,'Thermal Disturbance 2','fontsize',12)
        title('Thermal Disturbance Test','fontsize',12)
        xlabel('Time (s)','fontsize',12)
        ylabel('Temperature (^oC)','fontsize',12)
        
        
        





    
    
    
    
    
