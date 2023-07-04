%% Lab 2: The Calculation of the Modulus of Elasticity.
% Date 2/20/22
% Samuel Kramer
% 
% Two Parts: Calculation of MoE and plot of Deflection vs. Load
%
% 1. Will return a stress vs. strain graph of the data points collected
% 2. Will return the Modulus of Elasticity and the 95% confidence interval
% 3. Will return a graph of deflection vs. load applied

%% Part 1: Calculation of MOE
% To calculate MoE use (dR/R * GF) = dEpsilon where dEpsilon is change in
% strain
% Will return: 
%       1.  Stress vs. strain graph of the data points collected
%       2.  Modulus of Elasticity and the 95% confidence interval

% -- Setup
clc; clear; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%% Stress vs. Strain Curve %%%%%%%%%%%%%%%%%%%%%%%%%

% -- Parameters given by lab setup
voffset = .00865; % Volts
GF = 1.5; % Dimensionless
R = 120; % ohms
I = 1.875; % mm^4
y = 0.5; % mm

% -- Finding Change in strain for all 5 tests

    % -- Loading in data
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
    
    % -- Find mean of data
    V1 = mean(V1);
    V2 = mean(V2);
    V3 = mean(V3);
    V4 = mean(V4);
    V5 = mean(V5);
    V1 = V1 - voffset; % Returns the actual voltage change
    V2 = V2 - voffset;
    V3 = V3 - voffset;
    V4 = V4 - voffset;
    V5 = V5 - voffset;

    % -- Calculating change in resistance using dR = (Vout*4R)/ Vin
    dR1 = (V1*4*R)/5;
    dR2 = (V2*4*R)/5;
    dR3 = (V3*4*R)/5;
    dR4 = (V4*4*R)/5;
    dR5 = (V5*4*R)/5;

    % -- Calculating change in strain de = dR/(R*GF)
    de1 = dR1/(R*GF); % Given in m at point L1
    de2 = dR2/(R*GF);
    de3 = dR3/(R*GF);
    de4 = dR4/(R*GF);
    de5 = dR5/(R*GF);

% -- Calculating stress sigma = M*y / I
s1 = 25.431*y / I; %N/mm^2 = MPa
s2 = 38.146*y / I;
s3 = 50.861*y / I;
s4 = 69.524*y / I;
s5 = 82.257*y / I;

% -- Plot stress vs. strain 
strain = [de1 de2 de3 de4 de5];
stress = [s1  s2  s3  s4  s5];
plot(strain,stress,'*')
    xlabel('Strain (\epsilon)')
    ylabel('Stress (MPa)')
    ylim([0 30])
    title('Stress vs. Strain of a cantilever beam')
    hold on;
    grid on;
    
    % -- Plot a best fit line over the data
    coef = polyfit(strain,stress,1);
    bfl = @(x) x*coef(1)+ coef(2);
    fplot(bfl,[0, 0.001]) 
    legend('Experimental Data', 'Line of Best Fit');

%%%%%%%%%%%%%%%%%%%%%%%%% Calculation of MOE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Calculation of the modulus of elasticity
MeanE = mean(stress ./ strain);% Given in MPa
MeanE = MeanE / 1000;
    E1 = s1/de1; % Modulus of Elasticity for each load
    E2 = s2/de2;
    E3 = s3/de3;
    E4 = s4/de4;
    E5 = s5/de5;

% -- Calculation of a 95% confidence interval
N = length(strain);
Esem = std(stress ./ strain) / sqrt(N); % Standard error of mean calc.
CI95 = tinv([0.025 0.975], N-1); % T inverse to find Confidence Interval of two sided T-test
yCI95 = [Esem.*CI95]'; % Calculates the intervals of all values
interval = MeanE + yCI95;

% -- Outputs
fprintf('The 95 percent confidence interval of the two sided T-test is %3.3f to %3.3f MPa. \n',interval(1),interval(2));
fprintf('The mean modulus of elasticity is %3.3f GPa \n', MeanE);

%% Part 2: Calculation of the deflection
% Calculates the deflection based off of MoE and the constants of geometry
% of the lab and then compares to that of the experimental measured
% defleciton.
% Deflection is equal to delta = (FL^3)/(3EI)
% Will return:
%       1.  Graph of deflection vs. load with experimental and theoretical
%           resutlts, and will include error bars on experimental results

% -- Setup
clear;clc;format compact; close all;

%%%%%%%%%%%%% Theoretical vs. Experimental Deflection Graph %%%%%%%%%%%%%%%

% -- Parameters
L = 9*25.4; % length of moment arm in mm
I = 1.875; % Second moment of area in mm
E = 3.8669 * 10^4; % Modulus of elasticity in MPa

% -- Load in data
data = readmatrix('Lab 2 Data.xlsx');   % Load in experimental data

    % -- Extracting data
    expD = [data(2,5); data(3,5); data(4,5); 
            data(5,5); data(6,5)];      % Deflection  in mm
    F = [data(2,8); data(3,8); data(4,8); 
         data(5,8); data(6,8)];         % Load in N
    M = [data(2,7); data(3,7); data(4,7); 
         data(5,7); data(6,7)];         % Load in g

% -- Calculation of theoretical delta
thD = (F * (L^3)) ./ (3 * E * I);

% -- Outputs
plot(M,thD); hold on
    grid on
    title('\delta vs. Load Applied to Cantilever Beam')
    ylabel('\delta (mm)')
    xlabel('Load (g)')
    
    % -- Creation of error bars
    err = ones(length(expD),1)*0.5;
    errorbar(M,expD,err);
    legend('Theoretical \delta','Experimental \delta with Error Bars')
    