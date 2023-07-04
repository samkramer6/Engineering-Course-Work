%% Simulation Results of Vibrational Model


%% Part A
%   Graphing frequency response transmissibility for various
%   different stiffnesses in Y and Angular direction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;format compact; close all;

% Parameters
m = 1182; I = 96; cy = 9676; ct = 950; ky = [800000:1:900000]; 
kt = [90000:(9/30):120000]; hf = 435; w = [0:.001:100]; 

for i = 1: 8000 : length(ky)
    
% equation
    % r or frequency ratio
ry = w ./ (ky(i)./m).^(1/2);
    %Final equation
Try = ((1 + (cy.*w ./ ky(i)).^2) ./ ((1-((w.^2).*m)./ky(i)).^2 + (cy.*w ./ ky(i)).^2)).^(1/2);
% Plotting the solution
    % y solution
plot(ry, Try);
    grid on;
    hold on;
    xlabel('r (\omega/\omega_n)');
    ylabel('Transmissibility (F_T/F_0)');
    xlim([0 2]);
    title('Transmissibility in Y direction for various K_y values');
end
legend('K_y = 800000', 'K_y = 808000', 'K_y = 816000', 'K_y = 824000', 'K_y = 832000', 'K_y = 840000', 'K_y = 848000', 'K_y = 856000', 'K_y = 864000', 'K_y = 872000', 'K_y = 880000', 'K_y = 888000', 'K_y = 896000');
figure;
for i = 1: 8000 : length(kt)
    
% equation 
    % r or frequency ratio
rt = w ./ (kt(i)./I).^(1/2);
    % Final equation
Trt = ((1 + (ct.*w ./ kt(i)).^2) ./ ((1-(((w.^2).*I)./kt(i))).^2 + (ct.*w ./ kt(i)).^2)).^(1/2);
% Plotting solution 
    %Theta solution
plot(rt, Trt);
    grid on;
    hold on;
    xlabel('r (\omega/\omega_n)');
    ylabel('Transmissibility (F_T/F_0');
    xlim([0 2]);
    title('Transmissibility in \theta direction for various K_\theta values');
    
end  
legend('K_\theta = 90000', 'K_\theta = 92400', 'K_\theta = 94800', 'K_\theta = 97200', 'K_\theta = 99600', 'K_\theta = 102000', 'K_\theta = 104400', 'K_\theta = 106800', 'K_\theta = 109200', 'K_\theta = 111600', 'K_\theta = 114000', 'K_\theta = 116400', 'K_\theta = 118800');

%% Part B
%   Frequency response transmissibility curve for various damping rations
%   Zeta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc; format compact; close all; figure;

% Parameters
m = 1182; I = 96; r = [0: .01: 2]; z = [0:.01:2]; 

for i = 1:25:length(z)
% Equation
Trt = (1 + (2*z(i).*r).^2)./(((1-r.^2).^2) + (2*z(i).*r).^2);
%plotting solution
    plot(r, Trt);
    hold on;
    xlabel('r (\omega/\omega_n)');
    ylabel('Transmissibility (F_T/F_0)');
    grid on;
    xlim([0 2]);
    ylim([0 10]);
end
legend('\zeta = 0.25', '\zeta = 0.5', '\zeta = 0.75', '\zeta = 1', '\zeta = 1.25', '\zeta = 1.5', '\zeta = 1.75', '\zeta = 2');
title('Transmissibility for Various Values of \zeta');

%% Part C:
%   Frequency Response transmissibility curve for different values of h
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc; close all; format compact;

% Parameters
m = 1182; I = 96; cy = 9676; ct = 950; hf = .435; kt = 90000; ky = 800000;
h = [0:.1:.4]; Fy = 1000; tspan = [0 4];initials = [0.001 0 0.020 0]; 
w = [0:.1:32.4]';
r = (cy.*w./ky);
%   These values of Ky and Ktheta are based off of the transmissibility
%   graphs from part a) and part b)

for i = 1:length(h)
% Equation of motion definition
%   M[X''] + K[X] + C[X''] = BF

M = [m 0;
     0 I];
K = [ky -ky.*h(i);
     -ky.*h(i) ky.*h(i)+kt];
C = [cy -cy*h(i);
     -cy.*h(i) cy.*h(i)+ct];
 
B = [zeros(2); inv(M)]; %B vector that is used for forcing
F = [Fy; Fy*hf];

% Answer Solutions Matrices
%   X'' = (-K/M)*X -(C/M)X' + BF
A = [zeros(2) eye(2); -inv(M)*K -inv(M)*C];
B = [zeros(2); inv(M)]; %B vector that is used for forcing in spatial state
F = [Fy; Fy*hf]; %Force vector

% Equation 
Xdd = @(t,X) A*X(1:4) + B*F;

%Using ODE45
[t, values] = ode45(Xdd, tspan, initials);
X1 = values(:,1);
X2 = values(:,2);
Tr1 = X1(1:325,1);
Tr2 = X2(1:325,1);
Tr1 = (Tr1.*ky)./(Fy);
Tr2 = (Tr2.*kt)./(Fy*hf);

%plotting
subplot(4,1,1);
plot(t, X1,'linewidth', 1.5);
hold on;
title('Displacement in the Y direction; Pos(x(t))');
ylabel('displacement (m)');
grid on

subplot(4,1,2);
plot(t, X2,'linewidth', 1.5);
hold on;
title('Displacement in the \theta direction; Pos(x(t))');
ylabel('displacement (rad)');
grid on
xlabel('Time (s)');

subplot(4,1,3);
plot(r, Tr1)

subplot(4,1,4);
plot(r, Tr2)


end

