%% ME 4564 -- Vehicle Control Project 1
% Sam Kramer                                                       10/03/22
% This script will be the MATLAB code that will be used to solve the work
% for project 1 of the class. This will model tires in two separate ways
% for comparison using a linear tire model and a Pacejka tire model


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part 1: Plot Lateral Force vs. Slip Angle alpha

% --Setup 
clear; clc; format compact; close all;

% --Parameters
    alpha = [0:0.01:10]';               % Slip angle vector
    mass = 1031;                        % Mass of vehicle (kg)
    front_dist = 0.60;                  % Front weight distribution (60%)
    rear_dist = 0.40;                   % Rear weight distribution (40%)
    gamma = 0;                          % Camber of vehicle
    
    Fyf = zeros(length(alpha),5);       % Initialize front Fy solution
    Fyr = zeros(length(alpha),5);       % Initialize rear Fy solution 
    
    % --Read coefficient data
        A = readmatrix('P1.xlsx');      % Read Excel sheet of coefficients
        a = A(1:18,2:6);                % Lateral force coefficients

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Front Tire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Calculate load on tire
    weight = mass*9.81;                 % Calculating force
    Fzf = (weight * front_dist)/2;      % Front weight on a single tire
    Fzf = Fzf/1000;                     % Calculate to kN
                          
% --Calculating Lateral Force Coefficients

    % --Calculate Cy
        C = a(1);                       
        
    % --Calculate Dy (Peak Factor)
        Df = ((a(2,:).*(Fzf^2)) + (a(3,:).*Fzf));       

    % --Calculate BCD (Stiffness)
        kf = (a(4,:)).*sin(2.*atan(Fzf ./ a(5,:)));   
        
    % --Calculate B (Stiffness Factor)
        Bf = kf ./ (C.*Df);                             
    
    % --Calculate Sh (Horizontal Shift) 
        Shf = a(9,:).*Fzf + a(10,:);                              
       
    % --Calculate Sv (Vertical Shift)
        Svf = a(12,:).*Fzf + a(13,:);                   
        
% --Calculate Lateral Force

for i = 1:length(alpha)
        
    % --Calculate Ba (Slip angle composite)
        Baf = Bf.*(alpha(i) + Shf);

    % --Calculate E
        Ef = (a(7,:).*Fzf + a(8,:)).*(1 - a(18,:)).*sign(alpha(i) + Shf);
            
    % --Calculate Fy 
        Fyf(i,:) = Df.*sin(C.*atan(Baf - Ef.*Baf + Ef.*atan(Baf))) + Svf;
 
end
    
% --Plot Data
    figure(1)
plot(alpha,Fyf,'-')
    hold on
    grid on
    xlabel('Slip Angle (\alpha)')
    ylabel('Lateral Force (N)')
    title ('Lateral Force vs. Slip Angle for 5 Front Tires');
    lgd = legend('P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17');
    lgd.Location = 'southwest';
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rear Tire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Calculate Load on Tire
    fzr = (weight*rear_dist)/2;         % Weight on a single rear wheel
    Fzr = fzr/1000;                     % Convert N to kN

% --Calculate Coefficients
    
    % --Calculate D (Peak Factor)
        Dr = Fzr.*(a(2,:).*Fzr + a(3,:));
        
    % --Calculate K (Cornering Stiffness)
        Kr = a(4,:).*sin(2.*atan(Fzr ./ a(5,:)));
        
    % --Calculate B (Stiffness Factor)
        Br = Kr ./ (C.*Df);
    
    % --Calculate Sh (Horizontal Shift)
        Shtr = a(9,:).*Fzr + a(10,:);
    
    % --Calculate Sv (Vertical Shift)
        Svr = a(12,:).*Fzr + a(13,:);
        
% --Calculate Lateral Force
for i = 1:length(alpha)
        
    % --Calculate Ba (Slip angle composite)
        Bar = Br.*(alpha(i) + Shtr);
        
    % --Calculate E
        Er = a(7,:).*Fzr + a(8,:).*(1-a(18,:)).*sign(alpha(i) + Shtr);
        
    % --Calculate Fyr
        % Try iterating through to avoid issues with adding in E to the
        % equation
        Fyr(i,:) = Dr.*sin(C.*atan(Bar - Er.*Bar + Er.*atan(Bar))) + Svr;

end

% --Plot Data
figure(2)
plot(alpha,Fyr,'-')
    hold on
    grid on
    xlabel('Slip Angle (\alpha)')
    ylabel('Lateral Force (N)')
    title ('Lateral Force vs. Slip Angle for 5 Rear Tires');
    lgd = legend('P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17');
    lgd.Location = 'northwest';
    
    
%% Part 2: Calculate Cornering Stiffness for All Tires
    % From this part use the coefficients from the magic formula to find
    % all the cornering stiffnesses for each tire
        % This will be used to derive a linear tire model in the next
        % section
        
% --Setup
    clc;
        
% --Calculate Cornering Stiffness
    Cornering_Stiffness_Front = kf(:,:);        % Takes the BCD Calc for front
    Cornering_Stiffness_Rear = Kr(:,:);         % Takes the BCD calc for rear

% --Display cornering stiffnesses in a table
    rows = {'Front Tires','Rear Tires'};
    vars = {'Cornering Stiffness (N/deg)'};
    corneringStiffness = [Cornering_Stiffness_Front; Cornering_Stiffness_Rear];
    t = table(corneringStiffness,'RowNames',rows,'VariableNames',vars);
    disp(t)
    fprintf('\n \n');

%% Part 3: Compare to Linear Model
    % This section will take the cornering stiffnesses calculated in part 1
    % and then calculate the linear Fy using the definition of linear
    % cornering stiffness:
    %                       K*alpha = Fy
    
% --Parameters
    cAlphaFront = Cornering_Stiffness_Front;    % Reformat front vector
    cAlphaRear = Cornering_Stiffness_Rear;      % Reformat front vector
    
% --Calculate linear model
    FyLf = cAlphaFront.*alpha;                  % Front linear Fy
    FyLr = cAlphaRear.*alpha;                   % Rear linear Fy
    
% --Plot linear model
    
    % --Front Tires
    figure(1)
    plot(alpha,FyLf);
    legend('P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17',...
            'P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17')
    
    % --Rear Tires
    figure(2)
    plot(alpha,FyLr);
    legend('P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17',...
            'P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17')    

%% For Fun: Develop Entire Pacejka Magic Formula    
    
% --Setup
    clc;format compact;

% --Parameters
    c = A(21:length(A),2:6);                % Coefficients Vector
    alpha = -1:0.001:1;                     % Alpha for aligning torque
    Mtf = zeros(length(alpha),5);           % Initialize Mtf soln vector
    Mtr = zeros(length(alpha),5);           % Initialize Mtr soln vector
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Front Tire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Calculate Coefficients

    % --Calculate Ct (Shape Factor)
        Ct = c(1,:);
    
    % --Calculate Dt (Peak Factor)
        Dtf = Fzf.*(c(2,:).*Fzf + c(3,:));
    
    % --Calculate Kt (Aligning Stiffness)
        Ktf = Fzf.*(c(4,:).*Fzf + c(5,:)).*exp(-c(6,:).*Fzf);
    
    % --Calculate Bt (Stiffness Factor)
        Btf = Ktf ./ (Ct.*Dtf);
    
    % --Calculate Sht (Horizontal Shift)
        Sht = c(12,:).*Fzf + c(13,:);
    
    % --Calculate Svt (Vertical Shift)
        Svt = c(15,:).*Fzf + c(16,:);
    
% --Calculate Front Aligning Torque 
    
    for i = 1:length(alpha)
        
        % --Calculate Bat
            Baf = Btf.*(alpha(i) + Sht);
        
        % --Calcuate E
            Etf = abs((c(8,:).*(Fzf^2) + c(9,:).*Fzf + c(10,:)).*(1-c(21,:)).*sign(alpha(i) + Sht));
        
        % --Calculate Mtf
            Mtf(i,:) = Dtf.*sind(Ct.*atand(Baf -Etf.*Baf + Etf.*atand(Baf))) + Svt;
        
    end
    
% --Plot Aligning Torque
figure(3)
plot(alpha,Mtf,'-');
    hold on
    grid on
    xlabel('Slip Angle (\alpha)')
    ylabel('Aligning Torque (N-m)')
    title ('Aligning Torque vs. Slip Angle for 5 front Tires');
    legend('P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17')
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rear Tire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --Calculate Coefficients

    % --Calculate Dt (Peak Factor)
        Dtr = Fzr.*(c(2,:).*Fzr + c(3,:));
    
    % --Calculate Kt (Aligning Stiffness)
        Ktr = Fzr.*(c(4,:).*Fzr + c(5,:)).*exp(-c(6,:).*Fzr);
    
    % --Calculate Bt (Stiffness Factor)
        Btr = Ktr ./ (Ct.*Dtr);
    
    % --Calculate Sht (Horizontal Shift)
        Shtr = c(12,:).*Fzr + c(13,:);
    
    % --Calculate Svt (Vertical Shift)
        Svtr = c(15,:).*Fzr + c(16,:);
    
% --Calculate Rear Aligning Torque
    
    for i = 1:length(alpha)
        
        % --Calculate Bat
            Bar = Btr.*(alpha(i) + Shtr);
        
        % --Calcuate E
            Etr = abs((c(8,:).*(Fzr^2) + c(9,:).*Fzr + c(10,:)).*(1-c(21,:)).*sign(alpha(i) + Shtr));
        
        % --Calculate Mt
            Mtr(i,:) = Dtr.*sind(Ct.*atand(Bar -Etr.*Bar + Etr.*atand(Bar))) + Svtr;
        
    end
    
% --Plot Aligning Torque
figure(4)
plot(alpha,Mtr,'-');
    hold on
    grid on
    xlabel('Slip Angle (\alpha)')
    ylabel('Aligning Torque (N-m)')
    title ('Aligning Torque vs. Slip Angle for 5 Rear Tires');
    legend('P225/60 R16','P225/55 R16','P205/55 R16 (#1)','P205/55 R16 (#2)','P225/45 R17')
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
