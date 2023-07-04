%% ME 4984 Homework #6 
% Determine the vector fields of the stream function for 


% --Setup
clear; clc; format compact; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 2(c) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Plot a vector plot of the flow field
    [x,y] = meshgrid(0:31,-10:10);      % Define flow field
    u = 3.*(x.^2) + 1;                  % x velocity component vector
    v = -6.*x.*y;                       % y velocity component vector
    quiver(x,y,u,v,'filled')            % Plot vector fields
        hold on
        xlim([-0.5 31]);
        ylim([-10 10]);
        grid on
        title('Vector Plot of Flow Field')
        xlabel('X location');
        ylabel('Y location');
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 2(e) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% --Plot contour lines of streamlines
    psi = 3.*(x.^2).*y + y;
    contour(x,y,psi,30);
    legend('Velocity Flow Field','Flow Streamlines');
    
% --Using curl function plot the vorticity
    figure()
    [curlZ, Angular_velocity] = curl(x,y,u,v);
    contourf(x,y,curlZ,10);
        grid on
        title('Intensity of the vorticity of the flow')
        xlabel('X location');
        ylabel('Y location');
        legend('Vorticity Intensity in Z direction')
    
% --Plot a color contour plot of the   
    figure()
    contourf(x,y,psi,30);
        xlim([0 31]);
        ylim([-10 10]);
        grid on
        title('Contour plot of streamline function')
        xlabel('X location');
        ylabel('Y location');
    

    
    

    
    
    
    
    