%% ME 4005 Lab 6 Data Analysis
% Sam Kramer                                                    29 APR 2022
% This script will be the primary data analysis script that will be used in
% the final report

%% Part 1
% Part 1 was the creation of an airfoil that was used in the data
% collection portion of this lab.

%% Part 2 
% This is the matlab script for Part 2 of the lab, the pressure and voltage
% data validation and calibration
%       Must be in the correct folder to run this script
% Will return:
%               1. Plot with calibration curve
%               2. Table with data and corresponding voltage number

% -- Setup
clear; clc; close all; format compact;

%%%%%%%%%%%%%%%%%%%%%%%%% Pressure Calibration %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Load in data
pos2in = load('Lab6_P2S6_2inH20_Measurement'); % Postive 2 inches H2O
pos1in = load('Lab6_P2S6_1inH2O_Measurement'); % Postive 1 inches H2O
sta0in = load('Lab6_P2S6_0inH20_Measurement'); % Static 0 inches H2O
neg1in = load('Lab6_P2S6_Neg_1inH20_Measurement');  % Negative 1 in H2O
neg2in = load('Lab6_P2S6_Neg_2inH20_Measurement');  % Negative 2 in H2O

% -- Select data vectors
pos2 = pos2in.v1;       % +2 in H2O data
pos2Time = pos2in.t;    % Time vector for the data

pos1 = pos1in.v1;       % +1 in H2O data
pos1Time = pos1in.t;    

zeroH = sta0in.v1;       % 0 in H2O data
timeZ = sta0in.t;

neg1 = neg1in.v1;       % -1 in H2O data
neg1Time = neg1in.t;

neg2 = neg2in.v1;       % -2 in H2O data
neg2Time = neg2in.t;


% -- Find mean data
pos2 = mean(pos2);      % Finds the mean value of the H2O 
pos1 = mean(pos1);
zeroH = mean(zeroH);
neg1 = mean(neg1);
neg2 = mean(neg2);

% -- Put into vectors
voltage = [neg2 neg1 zeroH pos1 pos2]';
pressure = [-2:2]';

% -- Plot data 
plot(voltage,pressure,'o','Linewidth',1.5)              % Plot Data
    grid on
    hold on
    ylabel('Pressure (in H_2O)')
    xlabel('Voltage (Volts)')
    title('Voltage vs. pressure calibration plot')
    
% -- Extract and plot a calibration curve
 P = polyfit(voltage,pressure,1);                       % Find Poly values
 BFL = @(x) P(1)*x + P(2);                              % BFL equation
 fplot(BFL,'Color',[0.7 0.1 0.4],'Linewidth',1.5);      % Plot BFL
    hold on
    xlim([0.5 1.7])
    legend('Data','Best Fit Line')
    text(1,-1,'Pressure = 6.3329 * Voltage - 6.4778')
    
% -- Convert to Pascal
Pa = pressure * 248.84;     % Convert data to Pascal
    
% -- Make a table   
table = table(pressure,Pa,voltage);     % Make table
disp(table)                             % Display table created

%% Part 3
% This is the matlab script for part 3 of the lab, the static pressure
% distribution measurements.
% Will return:
%             1.

% -- Setup
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Static Pressure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Parameters
P = [6.3329 -6.4778];           % BFL Pressure calibration coefficients
location = [0.13 0.24 0.58];    % Normalized location of taps

w = 100/1000;                                   % length (m)
rho = 1.225;                                    % Density of air (kg/m^3)
L = [.016 .0175 .037 .074 .018 .028 .070];      % length of segments (m)
angles = [0 56 41 14 -58 -38 -15];              % angles (degrees)    
angles10 = angles - 10;
angles15 = angles - 15;
areas = L.*w;

% -- Load in data for all
    % 0 degree angle of attack
        p0a0 = load('P0_A0');       % P0 hole
        s1a0 = load('Ps1_A0');      % Ps1 hole
        s2a0 = load('Ps2_A0');      % Ps2 hole
        s3a0 = load('Ps3_A0');      % Ps3 hole
        p1a0 = load('Pp1_A0');      % Pp1 hole
        p2a0 = load('Pp2_A0');      % Pp2 hole
        p3a0 = load('Pp3_A0');      % Pp3 hole
    
    % 10 degree angle of attack
        p0a10 = load('P0_A10');
        s1a10 = load('Ps1_A10');
        s2a10 = load('Ps2_A10');
        s3a10 = load('Ps3_A10');
        p1a10 = load('Pp1_A10');
        p2a10 = load('Pp2_A10');
        p3a10 = load('Pp3_A10');
    
    % 15 degree angle of attack
        p0a15 = load('P0_A15');
        s1a15 = load('Ps1_A15');
        s2a15 = load('Ps2_A15');
        s3a15 = load('Ps3_A15');
        p1a15 = load('Pp1_A15');
        p2a15 = load('Pp2_A15');
        p3a15 = load('Pp3_A15');
    
% -- Finding mean voltage of each data vector
    % 0 degree angle of attack
        p0a0 = mean(p0a0.v1);       % P0 hole
        s1a0 = mean(s1a0.v1);       % Ps1 hole
        s2a0 = mean(s2a0.v1);       % Ps2 hole
        s3a0 = mean(s3a0.v1);       % Ps3 hole
        p1a0 = mean(p1a0.v1);       % Pp1 hole
        p2a0 = mean(p2a0.v1);       % Pp2 hole
        p3a0 = mean(p3a0.v1);       % Pp3 hole
    
    % 10 degree angle of attack
        p0a10 = mean(p0a10.v1);
        s1a10 = mean(s1a10.v1);
        s2a10 = mean(s2a10.v1);
        s3a10 = mean(s3a10.v1);
        p1a10 = mean(p1a10.v1);
        p2a10 = mean(p2a10.v1);
        p3a10 = mean(p3a10.v1);
 
    % 15 degree angle of attack
        p0a15 = mean(p0a15.v1);
        s1a15 = mean(s1a15.v1);
        s2a15 = mean(s2a15.v1);
        s3a15 = mean(s3a15.v1);
        p1a15 = mean(p1a15.v1);
        p2a15 = mean(p2a15.v1);
        p3a15 = mean(p3a15.v1);
    
% -- Place into vectors
a0 = [p0a0 s1a0 s2a0 s3a0 p1a0 p2a0 p3a0];   % 0deg voltages vector
a10 = [p0a10 s1a10 s2a10 s3a10 p1a10 p2a10 p3a10];  % 10deg voltages 
a15 = [p0a15 s1a15 s2a15 s3a15 p1a15 p2a15 p3a15];  % 15deg voltages
    
% -- Find pressure at corresponding voltage 
p0 = P(1) * a0 + P(2);      % Pressure for the 0deg angle of attack
p10 = P(1) * a10 + P(2);
p15 = P(1) * a15 + P(2);

% -- Convert pressure to Pa
p0 = p0 * 248.84;           % Calculates the in H20 pressure into Pascal
p10 = p10 * 248.84;
p15 = p15 * 248.84;  
    
% -- Plot pressures vs. location
    % 0 degree angle of attack
    plot(0,p0(1),'o')
        hold on
        grid on
    plot(location,p0(2:4),'color',[0.8 0.2 0.3],'Linewidth',1.5)
        hold on
        grid on
    plot(location,p0(5:7),'color',[0.2 0.3 0.8],'Linewidth',1.5)
        hold on
        grid on
        xlabel('Location of Tap')
        ylabel('Gauge Pressure (Pa)')
        title('Pressure at Normalized Location on Air foil at 0 Degree Angle of Attack')
        legend('Pressure at stagnant point','Suction Side','Pressure Side')
        xlim([0 1]);
        
    % 10 degree angle of attack
    figure(2)
    plot(0,p10(1),'o')
        hold on
        grid on
    plot(location,p10(2:4),'color',[0.8 0.2 0.3],'Linewidth',1.5)
        hold on
        grid on
    plot(location,p10(5:7),'color',[0.2 0.3 0.8],'Linewidth',1.5)
        hold on
        grid on
        xlabel('Location of Tap')
        ylabel('Gauge Pressure (Pa)')
        title('Pressure at Normalized Location on Air foil at 10 Degree Angle of Attack')
        legend('Pressure at stagnant point','Suction Side','Pressure Side')
        xlim([0 1]);
         
    % 15 degree angle of attack
    figure(3)
    plot(0,p15(1),'o')
        hold on
        grid on
    plot(location,p15(2:4),'color',[0.8 0.2 0.3],'Linewidth',1.5)
        hold on
        grid on
    plot(location,p15(5:7),'color',[0.2 0.3 0.8],'Linewidth',1.5)
        hold on
        grid on
        xlabel('Location of Tap')
        ylabel('Gauge Pressure (Pa)')
        title('Pressure at Normalized Location on Air foil at 15 Degree Angle of Attack')
        legend('Pressure at stagnant point','Suction Side','Pressure Side')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Lift and Drag %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Calculation of lift and drag forces
    % Drag
    d00 = p0(1)*cosd(0)*.0016;
    ds0 = p0(2)*cosd(56)*.0018 + p0(3)*cosd(41)*.0037 + p0(4)*cosd(14)*.0074;
    dp0 = p0(5)*cosd(-58)*.0018 + p0(6)*cosd(-38)*.0028 + p0(7)*cosd(-15)*.0070;
    Drag0 = d00 + ds0 + dp0;           % Newtons
    
    d010 = p10(1)*cosd(-10)*0.0016;
    ds10 = p10(2)*cosd(46)*0.0018 + p10(3)*cosd(31)*0.0037 + p10(4)*cosd(4)*0.0074;
    dp10 = p10(5)*cosd(-68)*0.0018 + p10(6)*cosd(-48)*0.0028 + p10(7)*cosd(-25)*0.007;
    Drag10 = d010 + ds10 +dp10;
    
    d015 = p15(1)*cosd(0 - 15)*.0016;
    ds15 = p15(2)*cosd(56 - 15)*.0018 + p15(3)*cosd(41 - 15)*.0037 + p15(4)*cosd(14 - 15)*.0074;
    dp15 = p15(5)*cosd(-58 - 15)*.0018 + p15(6)*cosd(-38 - 15)*.0028 + p15(7)*cosd(-15 - 15)*.0070;
    Drag15 = d015 + ds15 + dp15; 
    
    % Lift
    L00 = 0;
    Ls0 = p0(2)*0.0018*sind(56) + p0(3)*sind(41)*0.0037 + p0(4)*sind(14)*.0074;
    Lp0 = p0(5)*0.0018*sind(-58) + p0(6)*sind(-38)*0.0028 + p0(7)*0.07*sind(-15);
    Lift0 = -(L00 + Ls0 + Lp0)*cos(0);
    
    L010 = p10(1) * sind(-10) * 0.0016;
    Ls10 = p10(2)*0.0018*sind(46) + p10(3)*0.0037*sind(31) + p10(4)*0.0074*sind(4);
    Lp10 = p10(5)*0.0018*sind(-68) + p10(6)*0.0028*sind(-48) + p10(7)*0.007*sind(-25);
    Lift10 = -(L010 + Ls10 + Lp10);
    
    L015 = p15(1) * sind(0-15) * 0.0016;
    Ls15 = p15(2)*0.0018*sind(56 - 15) + p15(3)*0.0037*sind(41 - 15) + p15(4)*0.0074*sind(14 -15);
    Lp15 = p15(5)*0.0018*sind(-58 - 15) + p15(6)*0.0028*sind(-38 - 15) + p15(7)*0.007*sind(-15 - 15);
    Lift15 = -(L015 + Ls15 + Lp15);
    
% -- Calculating velocity of air
pitotV = load('AirVelocity_Data');
pitot = mean(pitotV.v1);
pitotP = P(1) * pitot + P(2);
pitotP = pitotP * 248.84;           % Defines pressure differential in Pa
airV = sqrt(2 * pitotP / rho);      % Fines the velocity (m/s) using bernoullis

% -- Calculating lift and drag coefficients
    % Drag
    DC0 = Drag0 / (.5 * rho * airV^2 * .011);
    DC10 = Drag10 / (0.5 * rho * airV^2 * .11 * .1);
    DC15 = Drag15 / (0.5 * rho * airV^2 * .11 * .1);
    
    % lift
    LC0 = Lift0 / (.5 * rho * airV^2 * .11 * .1);
    LC10 = Lift10 / (.5 * rho * airV^2 * .11 * .1);
    LC15 = Lift15 / (.5 * rho * airV^2 * .11 * .1);
    
% -- Vectors
Drag_Coefficient = [DC0 DC10 DC15]';
Lift_Coefficient = [LC0 LC10 LC15]';
AngleOfAttack = [0 10 15]';
CL_CD = Lift_Coefficient ./ Drag_Coefficient;
t = table(AngleOfAttack,Drag_Coefficient,Lift_Coefficient,CL_CD);
disp(t)

% -- Plot CL and CD
% Drag
figure
plot(AngleOfAttack,Drag_Coefficient)
    grid on
    xlabel('Angle of Attack (Degrees)')
    ylabel('Drag Coefficient C_D')
    xlim([-5 20]);
    title('Drag and Lift Coefficient vs. Angle of Attack')
    hold on

% Lift
plot(AngleOfAttack,Lift_Coefficient)
    grid on
    xlabel('Angle of Attack (Degrees)')
    ylabel('Coefficient Magnitude')
    xlim([-5 20])
    legend('Drag Coefficient','Lift Coefficient')
    

    





