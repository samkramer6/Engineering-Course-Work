%Initial Parameters
clear; clc; close all;format compact;
M1 = 5000; M2 = 4000; M3 = 4000; M4 = 1000;
K1 = 7000; K2 = 5000; K3 = 5000; K4 = 2500;
c = 50;F = 500; w = 2; t = 0:0.1:100;

% Equation of Motion
    %M[X''] +C[X'] + K[X] = BF
M = [M1 0 0 0;
     0 M2 0 0;
     0 0 M3 0;
     0 0 0 M4];
K = [K1+K2 -K2 0 0;
     -K2 K2+K3 -K3 0;
     0 -K3 K3+K4 -K4;
     0 0 -K4 K4];
C = [2*c -c 0 0;
     -c 2*c -c 0;
     0 -c 2*c -c;
     0 0 -c c];
B = [ 0;0;0;F];
 
 %% Modal Analysis of the sytem
 K_tilde = M^(-1/2) * K * M^(-1/2);
 syms a;
 Kk = K_tilde - a*eye(4);
 %Finding eigen values
 detKk = det(Kk);
        %plotting determinant to have visual representation of eigenvalues
            %fplot(detKk,[0 5])
            %ylim([-5 5])
            %grid on;
            %hold on;
            %yline(0);
            %title('eigenvalues');
 
[P, V] = eig(K_tilde);
LAMBDA = V;
C_tilde = 0*eye(4) + 0.1*LAMBDA;
S = M^(-1/2) * P;
%Forcing function transformation
B_tilde = P' * M^(-1/2)*B;

%% Plotting the SS response of the system
for j = 1:length(K)
   As = B_tilde(j)*(LAMBDA(j,j)-w^2)/((LAMBDA(j,j)-w^2)^2 + (C_tilde(j,j)*w)^2);
   Bs = B_tilde(j)*C_tilde(j,j)*w / ((LAMBDA(j,j)-w^2)^2 + (C_tilde(j,j)*w)^2);
   r(j,:) = As*cos(w*t) + Bs*sin(w*t);
end
Xss = S*r;
    X1 = Xss(1,:);
    X2 = Xss(2,:);
    X3 = Xss(3,:);
    X4 = Xss(4,:);

%Subplot plotting to see analysis
    subplot(4,1,1);
    plot(t, X1,'linewidth', 1.5);
    hold on;
    title('MDOF System Mass 1; Pos(x(t))');
    ylabel('displacement (mm)');
    grid on

    subplot(4,1,2);
    plot(t, X2,'linewidth', 1.5);
    hold on;
    title('MDOF System Mass 2; Pos(x(t))');
    ylabel('displacement (mm)');
    grid on

    subplot(4,1,3);
    plot(t, X3,'linewidth', 1.5);
    hold on;
    title('MDOF System Mass 3; Pos(x(t))');
    ylabel('displacement (mm)');
    grid on

    subplot(4,1,4);
    plot(t, X4,'linewidth', 1.5);
    hold on;
    title('MDOF System Mass 4; Pos(x(t))');
    xlabel('time (s)');
    ylabel('displacement (mm)');
    grid on

