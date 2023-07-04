%% Controls Lecture Notes 2/3/2022
% Learning how to develop block diagrams and TFs in MATLAB
% Conv function is used to multiply polynomials
clear; clc; format compact;

% This is how to calculate a transfer function of a simple
% mass-spring-damper system.
% The complex system function is:
%           mx'' + bx' + cx = F(t)

% Mass Spring Damper System
m = 10;     % mass(kg)
k = 100;    % Stiffness (N/m)
b = 7;      %Damping(N/s)
num = (1/m);
denom = [1 (b/m) (k/m)];
G = tf(num,denom);   % Definition of the transfer function

B = G.num{:};
A = G.den{:};
get(G);

% Finding the parameters of the system
    % This will return the Poles, the damping ratio, the frequency and all 
    % the constants in the systems 
damp(G)

% This is the manual calculation of everything delivered in damp() function
wn = sqrt(k/m)
r = roots(denom)
reig = eig(G)
poles = pole(G)

%% Block Diagram Reduction
% This is how to create a block diagram in MATLAB to create a TF

clear; clc; format compact;


% Creation of a series transfer function
% This is creating a series function, and when we look at a block diagram
% we remember that a series block means that the two blocks are multiplied
% together:
%      ----> G1 ----> G2 ----> Y(s) = G1*G2

% Series creation
num1 = 10; den1 = [1 2 10]; sys1 = tf(num1,den1);

num2 = [1 2]; den2 = [1 3 17]; sys2 = tf(num2,den2);

sys12a = series(sys1,sys2); % First method using series

sys12b = sys1 * sys2; % Second method using multiplication

% Parallel is like so:
% Remember that parallel blocks are added together and we can simply use
% the function parallel()

sys12c = parallel(sys1,sys2); % Premade method

sys12d = sys1+sys2; % Hand done method

% The Feedback Function delivers the feeback

sys = feedback(sys1, sys2)       % If negative feedback is used (default)
sys = feedback(sys1, sys2,1)    %If positive feedback is used



