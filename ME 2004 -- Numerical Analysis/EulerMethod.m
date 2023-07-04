function[t,y] = EulerMethod(diffeq,tmax,h,y0)
%EulerMethod  Euler's method for integration of a single first order ODE
%
%Syntax:    [t,y] = EulerMethod(diffeq,tmax,h,y0);
%Input:     diffeq = the differential equation we are solving for
%           tmax = the stopping time or the max value of t
%           h = the stepsize for the method
%           y0 =  the initial condition of the function
%
%Outputs:   t = vector of independent time variable values: t(i) = t(i-1)*h
%           y = vector of numerical solutions
%

%initialize
t = 0:h:tmax;
n = length(t);
y = zeros(n,1);
y(1) = y0;

%compute
for i = 1:n-1
    y(i+1) = y(i) + h*diffeq(t(i),y(i));
end
end