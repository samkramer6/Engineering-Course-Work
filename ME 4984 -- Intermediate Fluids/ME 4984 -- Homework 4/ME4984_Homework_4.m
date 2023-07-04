%% ME 4984 Homework #4 The Dynamics of Maps
% Sam Kramer                                                        9/29/22
% This will be a numerical exploration of some of the ideas discussed in
% class. Derivations will be hand written, but this script will be used to
% generate the plots. All plots will include: caption, labelled axes,
% legend.
% Will Return:
%               1. 3x Cobweb diagrams
%               2. A graph depicting variation of x* with r
%               3. A graph depicting variation of eigenvalue with r
%               4. A bifurcation diagram of the logistic map
%               5. A graph depicting variation of Lyapunov exponent with r

%% Question 1: Cobweb Plot for Three Values of R
    % This section will return 3 cobweb diagrams with three different r
    % values

% --Setup
    clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%% Cobweb Diagrams %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    N = 100;                    % Number of iterations for each map
    X0 = 0.12345;               % Initial condition of x
    R = [0.5,2,3.7];            % 3 Values of r that will be tested
    x = linspace(0,1,102)';     % Range of x transposed to [N,1] matrix

% --Cobweb diagrams
    % This section will return 3 cobweb diagrams with three different r
    % values 
    
    % --Plot the first cobweb diagram when r = R(1)
        xn11 = logiMap(X0,R(1),N);      % Calculates map values to Xn
        figure(1);
        cobwebDiagram(x,R(1),xn11);     % Generates cobweb diagram
        
        % -- Setup cobweb diagram
            title('Cobweb Plot of Logistic Map when r = 0.5')
            legend('X_n = X_{n+1}','X_{n+1}= f(X_n)','Cobweb Plot')
        
    % --Second Cobweb; r = R(2)
        xn12 = logiMap(X0,R(2),N);      % Calculates map values to Xn
        figure(2);
        cobwebDiagram(x,R(2),xn12);     % Generates cobweb diagram
           
        % --Setup cobweb diagram
            title('Cobweb Plot of Logistic Map when r = 2')
            legend('X_n = X_{n+1}','X_{n+1}= f(X_n)','Cobweb Plot')
            
    % --Third Cobweb; r = R(3)
        xn13 = logiMap(X0,R(3),N);      % Calculates map values to Xn
        figure(3);
        cobwebDiagram(x,R(3),xn13);     % Generates cobweb diagram
        
        % --Setup cobweb diagram
            title('Cobweb Plot of Logistic Map when r = 3.7')
            legend('X_n = X_{n+1}','X_{n+1}= f(X_n)','Cobweb Plot')

%% Question 3: Plotting Variation of x* with r
    % This section of the script will plot the variation of x* with r for
    % each fixed point

% --Setup
    clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%% Plot Variation of x* %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    r1 = [0 1];                     % r value range for x* = 0
    r2 = linspace(1,3,100);         % Range of r values for 1< x* <3

% --Define the characteristic equations
    lambda1 = 0*r1;
    lambda2 = 1 - (1./r2);

% --Plot Numerical Solution
    % This numerical solution will be used to calculate the stable values
    % of 
    
    % --Plot for x*=0 from r <1
        plot(r1,lambda1,'-','LineWidth',1.5,'Color',[0 0.7 0.7])
            hold on
            
    % --Plot for x* = 1 - (1/r)
        plot(r2,lambda2,'-','LineWidth',1.5,'Color',[0.8 0.2 0.4])
        plot([1 3],[0 (1-(1/3))],'o','LineWidth',1.5,'Color',[0.8 0.2 0.4])

        %--Setup Plot
            grid on
            xlim([0 4])
            ylim([-.001 1])
            legend('X^* = 0','X^* = 1-(1/r)','Marginal Stability Point')
            ylabel('Fixed Points (X^*)')
            xlabel('r values')
            title('Variation of X^* With r for Each Fixed Points')

%% Problem 4: Plotting Variance of lambda with r
    % This section will be used to solve problem 4 and plot the variation
    % of the eigenvalue 'lambda' with r. On the plot the stability regions
    % will be labeled clearly. Also clearly indicate what the eigenvalue
    % equation you are using is.

% --Setup
    clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%% Plotting Variation of Lambda %%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    r1 = [0 1];                     % r value range for x* = 0
    r2 = linspace(1,4,100);         % Range of r values for 1< x* <3

% --Define the characteristic equations
    lambda1 = 0*r1;
    lambda2 = abs(2-r2);

% --Plot Numerical Solution
    
    % --Plot for 0< r <1
        plot(r1,lambda1,'-','LineWidth',1.5,'Color',[0.8 0.2 0.4])
            hold on

    % --Plot for 1< r <3
        plot(r2,lambda2,'-','LineWidth',1.5,'Color',[0.8 0.2 0.4])
        
    % --Stability line
        % This line will indicate the point where stability is reached
        yline(1,'--','LineWidth',1.5)
        
    % --Annotations
        % This will annotate the stable and unstable regions
        annotation('textarrow',[.3 .3],[.4 .6],'String','Unstable Region')
        annotation('textarrow',[.52 .52],[.27 .2],'String','Stable Region')
    
        %--Setup Plot
            grid on
            xlim([0 4])
            ylim([-.001 4])
            legend('\lambda = |2 - r| < 1')
            ylabel('Fixed Points (X^*)')
            xlabel('r values')
            title("Variation of \lambda With r for f ' (x^*)")

%% Question 5: Bifurcation Diagram creation
    % This section will solve question 5 of the homework and will generate
    % a bifurcation diagram of x versus r of the logistic map

% --Setup
    clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%% Bifurcation Diagram %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    X0 = 0.12345;                   % Initial Condition
    N = 1000;                       % Iterations to calculate fixed points
    M = 400;                        % Amount of stable points (M < N)
    r = linspace(0,4,N);            % R value range
    fixedX = zeros(N,M);            % fixed point value vector

% --Iterating logistic map
    for i = 1:length(r)

        lambda2 = logiMap(X0,r(i),N);
        lambda2 = lambda2((length(lambda2) - (M -1)):length(lambda2));
        fixedX(i,:) = lambda2;

    end

% --Plotting of Bifurcation Diagram
    plot(r,fixedX,'.','MarkerSize',1,'Color',[0.3 0.6 0.6])

    % --Setup Plot
        hold on
        grid on
        title('Bifurcation Diagram for Logistic Growth Map')
        xlabel('Replacement Rate (r)')
        ylabel('Steady State Fixed Point (X^*)')
        
%% Problem 6: Plotting the Lyapunov exponent versus r
    % For the range of r = [0,4], plot the lyapunov exponent versus r.
    % Clearly show all work and clearly indicate what expression you are
    % evaluating to determine the lyapunov exponent
        % Lyapunov exponent determines where a periodic solution is present
        % versus where a chaotic solution is present
            % follows:                        i=M
            %            lambda = lim{ (1/n)*sigma( ln|( r-2rx(i) )| ) }
            %                     n->M
            %                                            Where M = infinity
    
% --Setup
    clear; clc; format compact; close all;
    
%%%%%%%%%%%%%%%%%%%%%%%% Plotting Lyapunov Exponent %%%%%%%%%%%%%%%%%%%%%%%

% --Parameters
    r = linspace(0,4,2000);             % Range of rs that will be tested
    X0 = 0.5666;                        % Random initial condition
    N = 300;                            % Number of iterates 
    M = 5000;                           % Additional number of iterates
    lambda = zeros(length(r),1);        % Initialize the lambda equation

% --Calculate Lyapunov Exponent for Logistic Map
    % This for loop will calculate the value of lambda for each value of r
    for i = 1:length(r)
    
    % --Initialize loop
    sigma = 0;                      % Initialize the summing function

    % --Calculate start point for xn
    xn = logiMap(X0,r(i),N);        % Calculates x0 for lyapunov summing
    xn1 = xn(N);                    % Elminates transients
    
    % --For loop to calculate summation of all terms
    for j = 1:M
        
        % --Iterate to find sigma( ln( r-2rx(i) ) )
        xn1 = r(i)*xn1*(1-xn1);                     % Calculates x(i) for n
        lyapunov = log(abs(r(i) - 2*r(i)*xn1));     % Descriptor for Lambda
        sigma = sigma + lyapunov;                   % Summing at each itr
        
    end
    
    % --Divide by amount of iterations M
    lambda(i,1) = sum(sigma) / M;                   % Divide by number itr
    
    end

% --Plot solution
    plot(r,lambda,'-','LineWidth',1.5)
    yline(0,'--')

    % --Setup plot
        grid on
        hold on
        ylim([-1 1])
        xlim([0 4])
        ylabel('Lyapunov Exponent (\lambda)')
        xlabel('r values')
        title('Lyapunov Exponent \lambda versus r')
        legend('Lyapunov Exponent','Stability Line')
        text(1.6,0.5,'Unstable Zone')
        text(1.6,-0.3,'Stable Zone')
    
%% Function Definitions
    % This section will be used to define the functions that will be used
    % to generate the logistic map iteration values for use in the problems
    % for this homework. 
           
%%%%%%%%%%%%%%%%%%%%%%%% Logistic Map Function %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --logiMap() Definition
    function [xn1] = logiMap(X0,r,N)
    % This function will determine the logistic map equation that will be
    % called in the cobweb function later, and will calculate the discrete
    % map values for the inputs of initial guess, replacement rate r, and N
    % iterations
        % Logistic map defined by: X(n+1) = r*X(n)*(1-X(n))
            % Will output a vector of X(n) values fron 0 to 1
            % Will input a initial condition X0, a replacement rate r, and 
            % the number of iterations N
    
    % --Initialize output values
        xn1 = zeros(N+1,1);                     % Defines output vector
        xn1(1) = 0;                             % Starts at zero for loop 
        xn1(2) = X0;                            % Defines initial condition
    
    % --For loop to calculate X(n+1)
        for i = 2:N                             % x0 indexed at 2
            xn1(i+1) = r*xn1(i)*(1-xn1(i));     % Logistic map equation
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Skeleton Function %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% --skeleton() function definition
    function skeleton(x,r)
    % This function will be used to setup the plots that are used for the 
    % cobweb diagrams. This is a helper function that will only be called
    % within the cobwebDiagram() function
    % INPUTS: x = vector, r = replacement rate
    % OUTPUTS: single graph
    
    % --Plot X(n) = X(n+1)
        plot(x,x,'r')
        hold on
        
    % --Plot y = rx(1-x)
        % This will help determine the stable points of the system
        xn1 = @(x) r.*x.*(1-x);
        xn1 = xn1(x);
            plot(x,xn1,'b')
            hold on
        
    % --Setup plot correctly
        grid on
        xlim([0 1])
        ylim([0 1])
        xlabel('X_n')
        ylabel('X_{n+1}')
    
    end
    
%%%%%%%%%%%%%%%%%%%%%%%% Cobweb Generator Function %%%%%%%%%%%%%%%%%%%%%%%%

% --cobwebDiagram() function definition
    function cobwebDiagram(x,r,xn1)
        % This function will be the cobweb plotting function that will plot
        % the three cobweb plots
    
    % --Setup cobweb plot
        skeleton(x,r)       % Call skeleton function defined above
    
    % --Cobweb diagram lines
        % for loop will iterate lines creating the cobweb plots
        for i = 2:length(xn1)-1
            
            % --First line to xn+1 = f(xn) line
                q = quiver(xn1(i),0,0,xn1(i+1),1);
                    q.Color = [0 0.6 0.6];
                    q.MaxHeadSize = .2;
                    
            % --Line from xn+1 = f(xn) to xn = xn
                q2 = quiver(xn1(i),xn1(i+1),(xn1(i+1) - xn1(i)),0,0);
                    q2.Color = [0 0.6 0.6];
            
            % --Line from xn = xn back to xn axis   
                q3 = quiver(xn1(i+1),xn1(i+1),0,-xn1(i+1),0);
                    q3.Color = [0 0.6 0.6];
        end 
    
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   