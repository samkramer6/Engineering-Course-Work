% ME 4984: Homework 8
% Plots the Analytical solution, Forward Euler, and RK4 approximations of
% a given equation: dy/dt = -y.
% 
% Sam Kramer                                                        12Nov22
%
% Will return:
%               1. graph of exact values and a forward euler integration
%                  approximation for the same time step
%
%               2. Graph of 10 Forward Euler approximations with 10
%                  different time steps
%
%               3. Log-Log plot of error from FE and RK4 methods as the
%                  time-step increases
%
%               4. Graph of RK4 integration approximation for a time step
%                  of 0.2 seconds
%
%               5. Graph of 10 different RK4 approximations with 10
%                  different time steps
%
%               6. Graph depicting comparison of the actual value curve, a
%                  FE approximation with a timestep of 2 seconds, a RK4
%                  approximation with a timestep of 2 seconds.

% --Setup
    clear; clc; format compact; close all;

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    y0 = 1;                 % Initial condition
    dt = 0.2;               % Time step definiton {CHANGE IF NEEDED}
    t = 0:dt:1;             % Time range definition (s)

% --Define analytical equation
    y = exp(-t);       % Solved analytical equation
    
% --Plot analytical method
figure(1)
plot(t,y,'Linewidth',1.5,'Color',[0 0.5 0.5]);
    hold on;
    grid on;
    xlabel('Time (s)');
    ylabel('Y value');
    title('Parts 2 and 5: Forward Euler Approximation and Analytical Method')
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parts 4 and 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% --Setup
    FE = zeros(1,length(t));        % Initializes the y value matrix
 
% --Calculate FE approximation for dt = 0.2
    for n = 0:(length(t) - 1)
        
        % --See if n = 0, if so, make initial condition
        if n == 0
        % --Set initial value
            FE(1) = 1;              % Initial val declaration y(0) = 1
        else
        % --Calculate Y(n+1) using FE
            FE(n+1) = FE(n) - dt*FE(n);
        end
        
    end

% --Plot Forward Euler Approach
    plot(t,FE,'Linewidth',1.5,'Color',[0.7 0.3 0])  % Plot on same graph 
        legend('Part 5:Forward Euler (\DeltaT = 0.2)','Part 2: Analytical Method')
    
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dt vector has 10 values that will be perfect denominators of 1 so
% that analysis at t = 1 is possible for all without needing to
% interpolate the line. 
   
% --Setup
    dt = [0.005 0.01 0.02 0.025 0.04...
          0.05 0.0625 0.10 0.125 0.20]; % Redefine dt for 10 new values
    figure(2)                           % Plots on new figure
    error = zeros(10,1);                % Defines error vector
    
% --Calculate FE approx with 10 different dt values
    for i = 1:10                        % First for loop is for all dt vals
        
        % --Setup
            t = 0:dt(1,i):1;            % Redefine t vector
            FE = zeros(1,length(t));    % Redefine the time vector
        
        % --Forward Euler calculation
        for n = 0:(length(t)-1)
        
       % --See if n = 0, if so, make initial condition
            if n == 0
       % --Set initial value
                FE(1) = 1;           % Initial val declaration y(0) = 1
       % --Calculate Y(n+1) using FE
            else
                FE(n+1) = FE(n) - dt(i)*FE(n);
            end 
            
        end
        
        % --Plot FE solution
            plot(t,FE,'Linewidth',1)    % Plot on new graph
            hold on
            
        % --Calculate error
        error(i) = abs( min(y) - min(FE));  % Calculate error and store val
        
    end
    
% --Setup the integrated value plot
    grid on
    xlabel('Time (s)')
    ylabel('Y Values')
    title('Part 6: Comparison of FE with 10 different time steps')
    legend('\DeltaT = 0.005','\DeltaT = 0.01','\DeltaT = 0.02',...
            '\DeltaT = 0.025','\DeltaT = 0.04','\DeltaT = 0.05',...
            '\DeltaT = 0.0625','\DeltaT = 0.10','\DeltaT = 0.125',...
            '\DeltaT = 0.20')
% --Log of data and log of time
    logErrorFE = log10(error);      % linearize the error vector
    logTimeStep = log10(dt);        % Logarithm of time step vector

% --Setup the log-log plot of the error
    figure(3)
    plot(logTimeStep, logErrorFE, 'Linewidth', 1.5);
        grid on
        hold on
        xlabel('Log of time step')
        ylabel('Log of Error')
        title('Plot depicting relationship of error and time-step for Forward Euler')
            
% --Find slope of FE error
    p = polyfit(logTimeStep,logErrorFE,1);    % Extrapolate FE error slope
    slopeFE = p(1);                    % Declare slope
            
              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Setup
    dt = 0.2;                   % Redefine time-step
    t = 0:dt:1;                 % Redefine time vector
    RK4 = zeros(1,length(t));   % Calculate RK4 solution vector
    RK4(1) = 1;                 % Inital Conditions
    
% --Calculate RK4 approximations
    for i = 1:(length(t)-1)
     
            % --Declare K values
                k1 = -RK4(i);
                k2 = -(RK4(i) + (dt/2)*k1);
                k3 = -(RK4(i) + (dt/2)*k2);
                k4 = -(RK4(i) + dt*k3);
            % --Declare RK4 approximation function
                RK4(i+1) = RK4(i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);  
        
    end

% --Plot RK4 solution
    figure(4)
    plot(t,RK4,'Linewidth',1.5);
        grid on
        hold on
        title('Part 9: RK4 Integration for \DeltaT = 0.2');
        xlabel('Time (s)');
        ylabel('Y values');
   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 10 and 12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Setup
    dt = [0.005 0.01 0.02 0.025 0.04...
          0.05 0.0625 0.10 0.125 0.20]; % Redefine dt for 10 new values
    error = zeros(1,length(dt));        % Defines the error vector
    figure(5)
    
% --Calculate the RK4 for each dt
    for j = 1:10                        % First for loop is for all dt vals

        % --Setup
            ts = dt(j);                 % Define loop dt value
            t = 0:ts:1;                 % Redefine t vector
            RK4 = zeros(1,length(t));   % Redefine the time vector
            RK4(1) = y0;                % Define Inital Condition

        % --Calculate RK4 approximaiton
            for i = 1:(length(t)-1)
                
                % --Declare K values
                    k1 = -1*(RK4(i));
                    k2 = -1*(RK4(i) + (ts/2)*k1);
                    k3 = -1*(RK4(i) + (ts/2)*k2);
                    k4 = -1*(RK4(i) + ts*k3);

                % --Declare RK4 approximation function
                    RK4(i+1) = RK4(i) + (ts/6)*(k1 + 2*k2 + 2*k3 + k4);
                    
            end
         
        % --Plot FE solution
            plot(t,RK4,'Linewidth',1)   % Plot on new graph
            hold on

        % --Calculate error
        error(j) = abs(min(y) - min(RK4));  % Calculate error and store val

    end

% --Setup the integrated value plot
    grid on
    xlabel('Time (s)')
    ylabel('Y Values')
    title('Part 10: Comparison of RK4 with 10 different time steps')
    legend('\DeltaT = 0.005','\DeltaT = 0.01','\DeltaT = 0.02',...
            '\DeltaT = 0.025','\DeltaT = 0.04','\DeltaT = 0.05',...
            '\DeltaT = 0.0625','\DeltaT = 0.10','\DeltaT = 0.125',...
            '\DeltaT = 0.20')
        
% --Logarithm of RK4 error data
    logErrorRK4 = log(error(1:4));       % Linearize error by taking log of data
    logTimeStep2 = logTimeStep(1:4);      % Change to fit size of error data
    
% --Setup the log-log plot of the error
     figure(6)
     plot(logTimeStep2,logErrorRK4,'Linewidth',1.5);
            grid on
            hold on
            xlabel('Log of time step')
            ylabel('Log of Error')
            title('Plot depicting relationship of error and time-step for RK4')
            
% --Finding error line slope
    p = polyfit(logTimeStep2,logErrorRK4,1);     % Extrapolate error slope
    slopeRK4 = p(1);                            % define slope
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 14.5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Plot FE error
    figure(7);
    plot(logTimeStep, logErrorFE, 'linewidth', 1.5);
        hold on

% --Plot RK4 error
    plot(logTimeStep2, logErrorRK4, 'linewidth',1.5);

% --Setup plot
    grid on
    xlabel('Logarithm of Time Step (log(\DeltaT))');
    ylabel('Absolute Value of logarithm of Error (log|E|)');
    title('Comparison of Forward Euler Error to RK4 Error');
    lgd = legend('Forward Euler Error','RK4 Error');
    lgd.Location = 'SouthEast';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 14 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Parameters 
    dt = 2;                     % Timestep for RK4 and FE methods
    t = 0:dt:10;                % Time vector for RK4 and FE methods
    time = 0:0.01:10;           % Time vector for exact solutions
    FE = zeros(1,length(t));    % Initialize FE method solution vector
    RK4 = zeros(1,length(t));   % Initialize RK4 method solution vector

% --Exact solution
    
    % --Solve exact solution
        y = exp(-time);        % Solved analytical equation
   
    % --Plot exact solution
        figure(8)
        plot(time,y,'Linewidth',1.5);
            hold on

% --FE approximation
    
    % --Solve FE approximation
        FE(1) = 1;                  % Set initial value of FE solution 
        for n = 1:(length(t) - 1)   % Sovlves for FE(n+1) values
       
            % --Calculate Y(n+1) using FE
                FE(n+1) = FE(n) - dt*FE(n);  % Forward Euler definition
         
        end
    
    % --Plot FE approximation
        plot(t,FE,'Linewidth',1.5);
            hold on

% --RK4 approximation
    
    % --Solve RK4 approx
        RK4(1) = 1;         % Set initial value of RK4 solution 
        for i = 1:(length(t)-1)
     
            % --Declare K values
                k1 = -RK4(i);
                k2 = -(RK4(i) + (dt/2)*k1);
                k3 = -(RK4(i) + (dt/2)*k2);
                k4 = -(RK4(i) + dt*k3);
            % --Declare RK4 approximation function
                RK4(i+1) = RK4(i) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);  
        
        end
    
    % --Plot RK4 approx
        plot(t,RK4,'Linewidth',1.5);
            hold on

% --Setup plot
    xlabel('Time (s)');
    ylabel('Y values');
    title('Part 14: Comparison for \DeltaT = 2');
    legend('Actual Solution','Forward Euler','Runge-Kutta O^4');
    grid on
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Display slope data in a table
    t = table(slopeFE, slopeRK4);
    fprintf('The error slopes are:\n \n')
    disp(t)
% END