%% ME 4984 -- Homework 9
%{
    This will be used to simulate the lorenz system by using the RK4
    simulation. This will be used to solve part 1 of the homework
    assignment. This will utilize a for loop with all three coupled
    equations withinit. 
        Will return:
                        1. A graph depicting the Lorenz Attractor
                           simulation using an RK4 algorithm
                        2. A table depicting the Initial condition and the
                           fixed stable point for that set of parameters

    Sam Kramer                                                      30NOV22
%}

% --Setup
    clear; clc; format compact; close all;
    
% --Parameters

    % --RK4 parameters
        dt = 0.001;                     % Timestep of the lorenz system
        t = 0:dt:100;                   % Time vector for the solution

    % --Lorenz parameters
        
        % --Initial parameter conditions
            rho = 28*5;           % Chaotic = 28
            sigma = 10*5;         % Chaotic = 10
            beta = (8/3)*5;         % Chaotic = 8/3
            parameters = [rho sigma beta];  % Initialize parameter vector

% --Setup solution Vectors
    x = zeros(1,length(t));             % Inidtialize x solution vector 
    y = zeros(1,length(t));             % Initialize y solution vector
    z = zeros(1,length(t));             % Initialize z solution vector
    
% --Define Initial Conditions
    x(1) = randi([-20, 20]);            % Random initial condition for x
    y(1) = randi([-20, 20]);            % Random initial condition for y
    z(1) = randi([0, 50]);              % Random initial condition for z
   
% --For loop of RK4 equaiton
for n = 1:length(t)-1
    
    % --RK4 of x equation
        
        % --Declare K values
            k1 = sigma*( y(n) - x(n) );       
            k2 = sigma*( (y(n) + (dt/2)*k1) - (x(n) + (dt/2)*k1) ); 
            k3 = sigma*( (y(n) + (dt/2)*k2) - (x(n) + (dt/2)*k2) );
            k4 = sigma*( (y(n) + dt*k3) - (x(n) + dt*k3) ); 
        
        % --Solve RK4 equation
            x(n+1) = x(n) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);     % RK4 for x
    
    % --RK4 of y equation
    
        % --Declare K values
            k1 = rho*x(n) - x(n)*z(n) - y(n);
            k2 = rho*(x(n) + (dt/2)*k1) - ((x(n) + (dt/2)*k1)*(z(n) + (dt/2)*k1)) - (y(n) + (dt/2)*k1); 
            k3 = rho*(x(n) + (dt/2)*k2) - ((x(n) + (dt/2)*k2)*(z(n) + (dt/2)*k2)) - (y(n) + (dt/2)*k2);
            k4 = rho*(x(n) + dt*k3) - ((x(n) + dt*k3)*(z(n) + dt*k3)) - (y(n) + dt*k3);
        
        % --Solve RK4 equation
            y(n+1) = y(n) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);     % RK4 for y
    
    % --RK4 of z equation
        
        % --Declare K values
            k1 = x(n)*y(n) - beta*z(n);
            k2 = ((x(n) + (dt/2)*k1)*(y(n) + (dt/2)*k1)) - (beta*(z(n) + (dt/2)*k1));
            k3 = ((x(n) + (dt/2)*k2)*(y(n) + (dt/2)*k2)) - (beta*(z(n) + (dt/2)*k2));
            k4 = ((x(n) + (dt)*k3)*(y(n) + (dt)*k3)) - (beta*(z(n) + (dt)*k3));
        
        % --Solve RK4 equation
            z(n+1) = z(n) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
            
    % --Change Parameters with each loop
        % Changes values of parameters to rand value within 15% of the 
        % previous parameters value
    
        if 28/rho <= 0.4 || 10/sigma <= 0.4 || 2.6667/beta <= 0.4
            
            % --Reset if parameters get too large
            rho = 28;
            beta = 8/3;
            sigma = 10;
        
        elseif 28/rho >= 1.6 || 10/sigma >= 1.6 || 2.6667/beta >= 1.6
            
            % --Reset if parameters get too small
            rho = 28;
            beta = 8/3;
            sigma = 10;
            
        else
            
            % --New random value of parameters
            rho = rho*randi([85 115])/100;          % Change rho to new value
            beta = beta*randi([85 115])/100;        % Change beta to new value
            sigma = sigma*randi([85 115])/100;      % Change sigma to new value
            
        end
        
        % --Track parameters
            parameters = [parameters; rho, sigma, beta];
         
end

% --Plot lorenz attractor on a 3d plot
    % Use plot3(x,y,z) equation to do this. Type 'help plot3' for more info
    plot3(x,y,z,'Color',[0.2 0.2 0.7])
        hold on
    plot3(x(1),y(1),z(1),'*','Color',[0.7 0.2 0.2]);
    
    % --Setup plot
        grid on
        hold on
        xlabel('X values')
        ylabel('Y values')
        zlabel('Z values')
        title('The Lorenz attractor using an RK4 simulation')
    
% --Table of initial conditions and stable points

    % --Creat Table Variables
        Variable = ['x';'y';'z'];
        initialPoints = [x(1);y(1);z(1)];
        
    % --Create table
        tab = table(Variable,initialPoints);
        
    % --Setup table
        varNames = ["Variable","Initial Conditions"];
        tab.Properties.VariableNames = varNames;      % Change col. headings
        fprintf('The Initial Conditions and Stable Points for r = %3.0f, sigma = %3.0f, b = %3.3f:\n',rho,sigma,beta)
        disp(tab)
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
