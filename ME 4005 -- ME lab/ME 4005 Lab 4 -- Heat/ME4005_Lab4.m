%% ME 4005 Lab 4 Data Analysis
% This lab will have two parts to it to analyze the data from both parts of
% the lab.
% Part 1 will return:
%                       1. A single graph with the heat transfer
%                          coefficient plotted vs. time
%                       2. A representative average of the heat transfer
%                          coefficient for the system
% 
% Part 1 will return: 
%                       1. A graph with the theoretical heat flux based on
%                          temperature vs. time as well as the actual
%                          measured heat flux.
%                       2. A graph with the theoretical temperature vs.
%                          time as well as the measured temperature vs.
%                          time. 

%% Part 1: Configuration 1

% -- Setup
clear;clc;format compact; close all

% -- Load in data
data1 = csvread('Lab4_C1_1.csv');

% -- Configure data vectors 

t = data1(:,1);              % Time vector (s)
qpp1 = data1(:,2);           % Heat flux vector (W/m^2k)
T11 = data1(:,3);            % Temperature of Thermocouple 1 (Celcius)
Tinf1 = data1(:,4);          % Temperature of air (Celcius)

% -- Calculate the H vector
     % Follows eqn: h = q"/(T1 - T2)
h = qpp1./(T11 - Tinf1);

% -- Plot H vs. Time

plot(t,h,'Linewidth',1.25)   % Plot h vs. time
    hold on;
    grid on;
    xlabel('Time (s)')
    ylabel('Heat Transfer Coefficient (W/m^2k)')
    title('Convective Heat Transfer Coefficient vs. Time')
    xlim([0 500])
    ylim([0 25])
figure
plot(t,T11)

% -- Find average of h vector and output value
hAvg = mean(h);             % Calculate the mean value of h
fprintf('The average heat transfer coefficient is %3.3f \n',hAvg)
    
% -- Plot average on the h vs. t plot
yline(hAvg,'Linewidth',1.5) 
legend('Experimental h_{convection}','Average h_{convection}')

%% Part 2: Configure 2

% -- Setup
clear; clc; format compact; close all;

% -- Paramters

C = 887;            % Specific heat of Aluminum (J/g-K)
m = 14/1000;        % Mass of block (g)
Ah = .028^2;        % Area of heater (m^2)
As = 0.037;         % Surface area of heater (m^2)
h = 16.512;         % Convection coefficient (W/m^2k)

% -- Load in data
data2 = load('Lab4_C2_2');

% -- Configure data vectors

time = data2.t';
qpp2 = data2.v1';
T12 = data2.v2;
Tsurr = data2.v3;
Tinf2 = mean(data2.v3);
qth = zeros(1);
Tth = zeros(1);

% -- Calculation of theoretical q" using the temperatures
for i = 10:length(time)
    app = (m*C/Ah)*((T12(i) - T12(i-1))/(time(i) - time(i-1)));
    bpp = (h*As/Ah)*(T12(i-1) - Tinf2);
    qth(i,1) = app + bpp;
end

% -- Resize Vectors to eliminiate beginning small heat flux data
qth = qth(10:length(qth));
t = time(10:length(time)) - 1.6158;
qpp = qpp2(10:length(qpp2));

% -- Plot data
plot(t,qth)
    hold on;
    grid on;
plot(t,qpp,'Linewidth',1.5)
    xlabel('Time (s)')
    ylabel('Heat Flux (W/m^2k)')
    title('Heat Flux vs. Time')
    legend('Theoretical Heat Flux','Measured Heat Flux')
    figure

% -- Calculation of theoretical T
for j = 2:length(time)
    T(j,1) = T12(j-1) + (1/(m*C))*(time(j) - time(j-1))*(qpp2(j)*Ah-h*As*(T12(j-1) - Tinf2));
end
T(1,1) = T(2,1);

% -- Plot Data
plot(time,T,'Linewidth',1.5)
    hold on;
plot(time,T12,'b','Linewidth',1.5)
    hold on;
    grid on;
    xlabel('Time (s)')
    ylabel('Temperature (^oC)')
plot(time,Tsurr,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
    legend('Theoretical Temp','Measured Temp','Environmental Temp')
    title('Temperature vs. Time')





