%% ME4005 Prelab 3
% This the code for the calculations for prelab 3
%% Part 1
% a) What is the Mode shape
% b) Find the first three natural frequencies
% c) Plot first three mode shapes on a graph

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Setup
clear; clc; format compact; close all;

% a) Mode shape equation
    % EI * dy^4/dx^4 - m*w^2* dy/dx = 0
    
% b) Natural Frequencies

    % -- Parameters 
    
    E = 69 * 10^9;              % Modulus of elasticity of aluminum (Pa) 
    W = .0224;                  % Width (m)
    th = 0.95/1000;             % Thickness (m)
    L = 9 * .0254;              % Length (m)
    
    Ix = (1/12)*(W)*(th^3);     % Moment of Inertia (m^4)  
    A = W * th;                 % Cross Sectional Area (m^3)
    Rho = 2700;                 % Density (kg/m^3)
    m = Rho * A * L             % Mass (kg)
    x = [0:0.01:1];             % x vector for plot
     
    % -- Calculation of natural frequencies (rad/s)
     
    u = sqrt((E*Ix)/(Rho*A*L^4));    % This is same for all natural freq
    w1 = (1.875^2)*u;            % Natural Freq 1       
    w2 = (4.695^2)*u;           % Natural Freq 2
    w3 = (7.855^2)*u;           % Natural Freq 3
     
    % -- Calculation of natural frequencies (hz)
    
    hz1 = w1 / (2*pi);
    hz2 = w2 / (2*pi);
    hz3 = w3 / (2*pi);
    
    % -- Output of Deliverables
    
    fprintf('The first three natural frequencies are %3.2f rad/s, %3.2f rad/s, %3.2f rad/s.\n',w1,w2,w3)
    fprintf('In hz the natural frequencies are %3.2f hz, %3.2f hz, %3.2f hz \n',hz1,hz2,hz3)
    
 % c) Graphing the Mode Shapes
    % Equation given as f(x) = A{(sin(n*pi) - sinh(n*pi)) * (sin(B*x) - sinh(B*x)) 
    %                           + (cos(n*pi) - cosh(n*pi)) * (cos(B*x) - cos(B*x))}
    
    % -- First shape
    
    beta = 1.875;
    sigma = 0.7341;
    f1 = (cosh(beta.*x) - cos(beta.*x)) - sigma*(sinh(beta.*x) - sin(beta.*x));
    plot(x,f1);
        grid on;
        hold on;
        xlabel('X Distance');
        ylabel('Y distance');
        title('Different Mode Shapes of Beam');
    
    % -- Second Shape
    
    beta = 4.695;
    sigma = 1.0185;
    f2 = (cosh(beta.*x) - cos(beta.*x)) - sigma*(sinh(beta.*x) - sin(beta.*x));
    plot(x,f2);
        hold on;
    
    % -- Third Shape
    
    beta = 7.855;
    sigma = 0.9992;
    f3 = (cosh(beta.*x) - cos(beta.*x)) - sigma*(sinh(beta.*x) - sin(beta.*x));
    plot(x,f3);
        hold on;
        legend('mode 1','mode 2','mode 3')
%% Part 2
% i) Sensitivity of the strain guage
%       a) This part will have the calibration of the strain gauge
%       b) Sensitivity of the strain gauge
%
% ii) Equivalent stiffness of beam
%       c) Plot of load vs. delta
%       d) Find equivalent stiffness of the beam
%       e) Is the beam stiffness linear or non linear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Setup
clear; clc; format compact; close all; voffset = .00865; % Volts


% -- Intake data

data = readmatrix('Lab 2 Data.xlsx'); % data intake of displacement
    delta = [data(2,5) data(3,5) data(4,5) data(5,5) data(6,5)]'; % displacement in mm
V1 = load('2QuartersData'); % Load in selected data 
    V1 = V1.v1;             % Select data from Ch. 1
V2 = load('3QuartersData');
    V2 = V2.v1;
V3 = load('4QuartersData');
    V3 = V3.v1;
V4 = csvread('3QuartersPlusBlockData.csv');
    V4 = V4(:,2);
V5 = load('4QuartersPlusBlockData');
    V5 = V5.v1;
    
% -- Avgerage of data

V1 = mean(V1) - voffset;
V2 = mean(V2) - voffset;
V3 = mean(V3) - voffset;
V4 = mean(V4) - voffset;
V5 = mean(V5) - voffset;
V = [V1 V2 V3 V4 V5]';

% i) Sensitivity of strain gauge and Plot of deflection vs. voltage

    % -- Plot all the Data

    plot(delta,V,'*');
        hold on
        grid on
        xlabel('\delta at Beam End (mm)');
        ylabel('Output Voltage (V)');
        title('Voltage Output vs. Deflection of Beam at Free End')
        xlim([0 15])
        ylim([0 .001])

    % -- Trend Line calculations

    coef = polyfit(V,delta,1);
        fprintf('The correlation between volts and load is %3.5f mm/v \n',coef(1))

% ii) Equivalent Stiffness of the beam

% -- Input Load Data

load = [data(2,8) data(3,8) data(4,8) data(5,8) data(6,8)]'; %Load vector (N)

% -- Plot
figure
plot(delta,load,'*')
    hold on
    grid on
    xlabel('\delta at Beam End (mm)');
    ylabel('Load at Beam End(N)');
    title('Load on Beam vs. Deflection of Beam at Free End')
   
% -- Equivalent Stiffness of the beam

    coef = polyfit(delta,load,1);
        fprintf('The correlation between Delta and Load is %3.3f N/mm \n', coef(1))
    BFL = @(x) coef(1)*x + coef(2);
    fplot(BFL)
        hold on;
        legend('Data','0.27 N/mm')
disp('The beam stiffness appears to be linear and follows the trend line depicted in figure 2')
