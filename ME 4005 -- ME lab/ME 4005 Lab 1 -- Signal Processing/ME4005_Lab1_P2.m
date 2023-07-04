%% Part 2: Low Pass Filter lab section
% Calculating the Phase and the Magnitude of a low pass filter and
% comparing it to the theoretical values
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Converting data to different vector values

N = xlsread('ME4005_Lab1_ExperimentalResults.xlsx');
freq = N(:,10); % This retrieves the frequency of the signal in Hz
phase = N(:,8); % Retrieves phase in radians
vout = N(:,4); % Retrieves the output in volts
dbout = 70 + 20*log10(vout); % Converting to DB
phase = -phase.*180./pi;

% Bode Plot creation
        % Hf = R/(1+RjwC)
        % R is resistance, jw will be replaced by s in the bode function,
        % C is the capacitance.
        
% Parameters
R = 3300; C = .33*10^-5;

% Bode function
Hf = tf([0 0 R], [0 R*C 1]);
options = bodeoptions;
options.FreqUnits = 'Hz';
[mag, ph, w] = bode(Hf,options); % Returns a magnitude and a phase
    
    % Creating a magnitude vector to plot in DB
    mag = mag(:,:)'; 
    mag = 20*log10(mag);
    
    % Creating a phase vector in radians
    ph = ph(:,:)';
 
    % Calculating Cutoff Frequency (Hz)
    Cutoff = (1/(2*pi*R*C)); 

% Plotting the values onto the subplots

subplot(2,1,1)
semilogx(w, mag); % Plots the theoretical values
hold on;
semilogx(freq,dbout,'*r') % Plots the experimental values
hold on;
xlabel('Frequency (Hz)');
ylabel('Magnitude(Db)');
xline(Cutoff)
title('Plot of Data from Transfer Function');
legend('Theoretical','Experiemtal','Cutoff');

subplot(2,1,2)
semilogx(w,ph);
hold on;
semilogx(freq,phase,'*r')
hold on;
xlabel('Frequency (Hz)')
ylabel('Phase Shift (degrees)')
xline(Cutoff)
legend('Theoretical','Experiemtal','Cutoff');