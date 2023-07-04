%Newton Raphson Method
    %From ME2004 Homework 4 Question 1 part e)
function root = NewtonRaphson(y, yp, d0, es, itNum)
%
%Inputs:    y   = initial function we are finding the root of [function]
%           yp  = derivative of the initial function we are finding the
%                 root of. [function]
%           d0  = initial guess [scalar]
%           es  = step size [scalar]
%           itNum = amount of iterations desired [scalar]
%

xold = d0;
xnew = 2*es;
    for i = 1:itNum
        xold = xnew;
        xnew = xold - y(xold)/yp(xold);
    end
root = xnew;
end