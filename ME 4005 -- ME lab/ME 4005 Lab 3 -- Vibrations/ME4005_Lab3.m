%% ME Lab 4005 MATLAB Calculations and Work
% This will the be the required script for all of the calculations used in
% Data Analysis portion of the Lab report
% Two sections:
%           1. Displacement vs. Time responses of all cases
%           2. Spectral anaylsis of cases 1 and 2
%
% Samuel Kramer                                         Date: 10 March 2022

%% Section 1: Displacement vs. Time Response of All Cases
% Will return:
%               1. 4 plots of displacement vs. time for all cases
%               2. 1 plot of theoretical response
%               3. Damping ratio and coefficient of Case 1
    
% -- Setup

clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Circuit parameters

GF = 1.5;                   % Gauge Factor (Dimensionless)
R = 120;                    % resistance of resistors (ohms)
vIn = 5;                    % voltage input (v)
fs = 2000;                % Sample frequency (Hz)

% -- Beam parameters
    
E = 69 * 10^9;              % Modulus of elasticity of aluminum (Pa) 
W = .0224;                  % Width (m)
th = 0.95/1000;             % Thickness (m)
L = 8 * .0254;              % Length (m)
L1 = 7 * .0254;             % Length free end to the strain gauge (m)

I = (1/12)*(W)*(th^3);      % Moment of Inertia (m^4)
y = 0.5*10^-3;              % Distance to neutral axis (m)
A = W * th;                 % Cross Sectional Area (m^3)
Rho = 2700;                 % Density (kg/m^3)
m = Rho * A * L;            % Mass (kg)

% -- Theoretical parameters
    
x0 = [-.023 0];             % Initial conditions of the beam for case 1
ts = 0:0.01:7.5;            % Time vector (s)
xref = 0.001;               % Reference input for dB calculation (m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Voffset %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculation of the offset voltage to 'zero' system
    
% -- Load in data

voffset = load('Lab3_VoltageOffsetData');
voffset = voffset.v;
vOff = mean(voffset);

%%%%%%%%%%%%%%%%%%%%%%%%% Plotting Displacement %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % This section will calculate the displacement and plot all of the
    % responses as a function of time, they will be plotted on separate 
    % plots for easier viewing

% -- Load in data

dataIC = load('Lab3_InitialDisplacementTestData');
    vIC = dataIC.v;                                 % Voltage IC
    t = dataIC.t;                                   % Time vector
vImpulse = load('Lab3_ImpulseTestData').v;          % Voltage Impulse
vDamp1 = load('Lab3_ScotchTapeDampingTestData').v;  % Voltage Damping 1
vDamp2 = load('Lab3_GorillaTapeDampingTestData').v; % Voltage Damping 2
    
% -- Convert from voltage to displacement

    % -- Find actual voltage change 
        % Follows equation: V = Vread - Voffset
        
    vIC = vIC - vOff;           % Initial conditions
    vIm = vImpulse - vOff;      % Impulse 
    vD1 = vDamp1 - vOff;        % Scotch Tape Damping
    vD2 = vDamp2 - vOff;        % Gorilla Tape Damping
    
    % -- Calculate the change in resistance
        % Follows equation: dR = (Vout*4R)/ Vin
        
    dRIC = (vIC.*(4*R))./(vIn); % Initial conditions
    dRIm = (vIm.*(4*R))./(vIn); % Impulse 
    dRD1 = (vD1.*(4*R))./(vIn); % Scotch Tape Damping
    dRD2 = (vD2.*(4*R))./(vIn); % Gorilla Tape Damping
    
    % -- Calculate the change in strain read
        % Follows equation: de = dR/(R*GF)
        
    eIC = dRIC ./(R*GF);        % Initial conditions
    eIm = dRIm ./(R*GF);        % Impulse
    eD1 = dRD1 ./(R*GF);        % Scotch Tape Damping
    eD2 = dRD2 ./(R*GF);        % Gorilla Tape Damping
    
    % -- Calculate the deflection at the free end
        % Follows the equation: delta = (e*L^3)/(3*L1*y)
            % Normalizes the data to start at 0 (there is associated strain
            % with the beam before excitation due to gravity)
            
    deltaIC = ((eIC.*L^3)./(3*L1*y)) + 0.0017;
    deltaIm = ((eIm.*L^3)./(3*L1*y)) - 0.0025;
    deltaD1 = ((eD1.*L^3)./(3*L1*y)) + 0.0005;
    deltaD2 = ((eD2.*L^3)./(3*L1*y)) - 0.0008;
    
% -- Plot data vs. tIC

    % -- Initial Conditions Response
    
    figure(1);                  % Will denotate the figure as figure 1
    plot(t, deltaIC); 
        hold on
        grid on
        xlabel('Time (s)')
        ylabel('Displacement (m)')
        title('Initial Condition Response vs. Time')
        xlim([0 7.5])
        yline(0)
        
    
    % -- Impulse Response
    
    figure(2);
    plot(t, deltaIm); 
        hold on;
        grid on
        xlabel('Time (s)');
        ylabel('Displacement (m)');
        title('Impulse Response vs. Time');
        xlim([0 7.5]);
        yline(0);
        legend('Impulse Response','Reference Plane')
        figure;
    
    % -- Damped Response 1
    
    figure(3);
    plot(t, deltaD1); 
        hold on;
        grid on
        xlabel('Time (s)');
        ylabel('Displacement (m)');
        title('Scotch Tape Damped Response vs. Time');
        xlim([0 7.5]);
        yline(0);
        legend('Scotch Tape Damped Response','Reference Plane')
    
    % -- Damped response 2
    
    figure(4);
        plot(t, deltaD2);
        grid on
        hold on;
        xlabel('Time (s)');
        ylabel('Displacement (m)');
        title('Gorilla Tape Damped Response vs. Time');
        xlim([0 7.5]);
        yline(0);
        legend('Gorilla Tape Damped Response','Reference Plane');

%%%%%%%%%%%%%%%%%%%%%%%%%% Theoretical Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % This section will calculate the a theoretical model for the Initial
    % Condition response of the beam, and then will plot it on figure 1
    % Equation will be the following:
    %                   mx'' + kx = 0 where x0 = 20mm & x'0 = 0 mm/s
    %                   x'' = (-kx)/m
    %                   x'  = v
    %                   x'' = v'

% -- Calculation of k of beam
    % Follows the equation: k = (3*E*I) / (L^3)
    
k = 3*E*I / (L^3);      % (N/m)

% -- Calculation of the damping values of the beam
    % Follows the equation C = z*2*sqrt(k*m)
    
us = reallog(.0201/.0058)/(2*pi*15);
z = us / sqrt(1+(us^2));
c = 2*z*sqrt(k*m);
    fprintf('The damping ratio for case 1 is %3.4f\n',z)
    fprintf('The damping due to external factors is %3.4f (N/m)\n',c)

% -- Creation of the response vector using ode45 with damping

dxdt = @(t,xv) [xv(2);
                (-c*xv(2) - k*xv(1))/m];    % Differential eqn
[~,x] = ode45(dxdt,ts,x0);                  % ODE45 Evaluation
    theoreticalResponse = x(:,1);           % Select disp data
    ZeroVector = zeros(378,1);
    oneVector = -0.023*ones(10,1);
    TRd = [ZeroVector ; oneVector ; theoreticalResponse];
    time = 0:.01:11.38;                        % Rewriting of the time vector
    
% -- Creation of the response vector using ode45 without damping

dxdt = @(t,xv) [xv(2);
                (- k*xv(1))/m];             % Differential equation          
[~,x] = ode45(dxdt,ts,x0);                  % ODE45 evaluation
    theoreticalResponse = x(:,1);           % Select displacement data
    ZeroVector = zeros(378,1);  
    oneVector = -0.023*ones(10,1);
    TRf = [ZeroVector ; oneVector ; theoreticalResponse];   
    
        % -- Plot the responses
        
        figure(6)
        plot(time,TRf)         % Ideal undamped theoretical response
            hold on;
            grid on;
            title('Theoretical Response of Case 1')
            legend('Damped Response','Undamped Response')
            xlim([1.5 7.5]);
            legend('Experimental Response','Reference Plane','Theoretical Response')
         
us = reallog(.0231/.0089)/(2*pi*15);
z = us / sqrt(1+(us^2));
c = 2*z*sqrt(k*m);
    fprintf('The damping ratio for case 3 is %3.4f\n',z)
    fprintf('The damping for case 3 due to external factors is %3.4f (N/m)\n',c)
    
us = reallog(.0103556/.0080)/(2*pi*2);
z = us / sqrt(1+(us^2));
c = 2*z*sqrt(k*m);
    fprintf('The damping ratio for case 2 is %3.4f\n',z)
    fprintf('The damping for case 2 due to external factors is %3.4f (N/m)\n',c)
    
us = reallog(.02884/.00764)/(2*pi*15);
z = us / sqrt(1+(us^2));
c = 2*z*sqrt(k*m);
    fprintf('The damping ratio for case 4 is %3.4f\n',z)
    fprintf('The damping for case 4 due to external factors is %3.4f (N/m)\n',c)

            
%% Spectral Analysis of Data
% Will return:
%               1. 2 spectrum plots for cases 1 and 2

% -- Setup

clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%% Spectral Analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -- Calculate the MSV values of the responses of cases 1 and 2
    % Uses the given MATLAB fourier transfer function fft(x) to find the
    % spectral analysis, Use: 'help fft' for more info

    % -- Case 1
    
    IC = deltaIC(1,7760:13760);         % Resize the IC vector to 3s
    Ns = length(IC);
    spect_IC = fft(IC);                 % Fast Fourier Transform of data
    spect_IC = spect_IC ./ Ns;
    spect_IC(2:end) = 2.*spect_IC(2:end);
    spect_IC = spect_IC(1,1:300);       % Rezise vector to 300 Hz
        
        % -- MSV of the spectral analysis
            % Follows equation: MSV = RMS^2 = X^2 / 2
        
        IC_MSV = abs(spect_IC);
        IC_MSV = (IC_MSV.^2) ./ 2;      % Final MSV array
                          
    % -- Case 2
    
    Im = deltaIm(1,2058:8058);          % Resize the Im vector to 3s
    Ns = length(Im);    
    spect_Im = fft(Im);                 % Fast Fourier Transform of data
    spect_Im = spect_Im / Ns;           
    spect_Im(2:end) = 2.*spect_Im(2:end);
    spect_Im = spect_Im(1,1:300);       % Resize to only include to 300 Hz 
    
        % -- MSV of the spectral analysis
        
        Im_MSV = abs(spect_Im); 
        Im_MSV = (Im_MSV.^2)./2;      % Final MSV array

% -- Convert MSV values to dB values for plotting
    % Follows eqn: Lx = 10log10(MSV/(Xref^2))
 
    IC_MSV = 10*log10(IC_MSV/(xref^2));    % dB measurement of IC data
    Im_MSV = 10*log10(Im_MSV/(xref^2));    % dB measurement of Impulse data

% -- develop MSV response eqn as a function of Wn
    % Plot should indicate the frequency resolution in title
    % Plot should locate and lable the natural frequencies 
    
    freq = (0:(length(IC_MSV) - 1));
    
    % -- Case 1
    
    figure;
    plot(freq,IC_MSV,'o')
        hold on;
        xlim([0 300]);
        grid on;
        xlabel('Frequency (Hz)')
        ylabel('MSV Amplitude (dB - reference: 1mm)')
        title ('Spectral Analysis of Case 1 with a frequency resolution of 1Hz')
        xline(42,'r')
        
    % -- Case 2
    
    figure;
    plot(freq,Im_MSV,'o')
        hold on; 
        xlim([0 300]);
        grid on;
        xlabel('Frequency (Hz)')
        ylabel('MSV Amplitude (dB - reference: 1mm)')
        title ('Spectral Analysis of Case 2 with a frequency resolution of 1Hz')
        xline(48,'r')
        xline(253,'r')
        
% -- Output how many modes were present in the diagrams

fprintf('There is one mode present in case 1 at 42 Hz.\n')
fprintf('There is 2 modes present in Case 2 at 48 Hz and 253 Hz.\n')

    % -- Add text boxes to data

    figure(1)
        text(50,5,'Natural Frequency Mode 1, 42 Hz')
        
    figure(2)
        text(52,5,'Natural Frequency Mode 1, 48 Hz')
        text(200,5,'Natural Frequency Mode 2, 253 Hz')
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%