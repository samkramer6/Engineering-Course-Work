function [t,y] = RungeKutta4(diffeq,tmax,h,y0)
%HeunMethod     Heun's method for integration of a single first order ODE
%               Use this method to calculate single first order ODEs more
%               accurately than Euler's method.
%
%Syntax:        [t,y] = EulerMethod(diffeq,tmax,h,y0);
%Input:         diffeq = the differential equation we are solving for
%               tmax = the stopping time or the max value of t
%               h = the stepsize for the method
%               y0 =  the initial condition of the function
%
%Outputs:       t = vector of independent time variable: t(i) = t(i-1)*h
%               y = vector of numerical solutions
%

%initialize
t = 0:h:tmax;
n = length(t);
y = zeros(n,1);
y(1) = y0;

%Compute
for i = 1:n-1
    k1 = diffeq(t(i),y(i));
    k2 = diffeq((t(i)+h),(y(i)+h*k1));
    y(i+1) = y(i)+(h/2)*(k1+k2);
end

end