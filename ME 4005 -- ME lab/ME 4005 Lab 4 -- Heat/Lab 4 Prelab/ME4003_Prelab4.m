%% ME4005 Prelab #4
% This is the prelab for lab 4 and is used to calculate the heatflux and
% temperature as a function of time
% Will return:
%               1. A single graph with theoretical T vs. t and q" vs. t as
%               well as a realistic T vs. t and q" vs. t

% -- Setup
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Task #2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Parameters
m = 14/1000;            % Mass (kg)
c = 900;                % Specific heat (j/kg-k)
h = 10;                 % Convection coeff (W/m^2-k)
qpp = 1000;             % Step input heat flux from heater (W/m^2)
T0 = 13 + 273;          % Initial Temperature (k)
Ah = (28.34/1000)^2;    % Area of heater (m^2)
As = 0.0037;            % Surface area of aluminum block (m^2)
k = 273;                % Conduction constant (W/m-k)

% -- Calculation of Tss and time constant tau
Tss = T0 + (qpp/h)*(Ah/As);
Tsteady = Tss - 273
tau = (m*c)/(h*As)

% -- Plotting T vs. t and qpp due to convection vs. t
    % Temperature
t = 0:10:2000;
T = (T0 - Tss).*(exp(-t./tau)) + Tss;
T = T - 273;
figure(1)
plot(t,T,'Linewidth',1.5)
    hold on;
    grid on;
    ylim([10 45])
    yline(Tss - 273,'Color',[0.4660 0.6740 0.1880],'Linewidth',1.5)
    
    % Heat flux
        % Transient heat flux in to block = qheater - qconvection
T = T + 273;
qppconv = h.*(T - T0);  % Convective heat flux out
%qppin = qpp - qppconv;  % Heat flux into the block
figure(2)   
plot(t,qppconv)
    hold on
    yline(qpp,'Linewidth',1.5)

% -- Plotting actual values
for i = 2:length(t)
    T(i) = T(i-1) + (1/(m*c))*(10)*(qpp*Ah - h*As*(T(i - 1) - T0));
    i = i + 1;
end
T = T - 273;
figure(1)
plot(t,T,'.')
    hold on;
    title('Temperature of Block vs. time')
    legend('Theoretical Temperature','Steady State Temperature','Actual Temperature')
T = T + 273;

for j = 2:length(t)
    q(j) = ((m*c)/Ah)*((T(j) - T(j - 1))/(10)) + h*(As/Ah)*(T(j) - T0);
    j = j + 1;
end
q(1) = qpp;
q = q - qppconv;
figure(2)
plot(t,q)
    hold on
    grid on
    xlabel('Time (s)')
    ylabel('Heat Flux (W/m^2)')
    title('Heat Flux vs. Time')
    legend('Theoretical Transient Heat Flux','Heat Flux in by Heater','Actual Transient Heat Flux')

