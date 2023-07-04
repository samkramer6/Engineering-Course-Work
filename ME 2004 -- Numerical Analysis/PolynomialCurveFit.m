function [a,b,c] = PolynomialCurveFit(x,y)
% POLYNOMIALCURVEFIT: given a set of coordinates, fit a 2nd order polynomial to them
% Inputs: 
% x: x values in a row vector [ND] (vector)
% y: y values in a row vector [ND] (vector)
% 
% Outputs:
% a, b, c: Coefficients of the polynomial curve fit y = a + bx + cx^2 
% 
% Write your code below:

A = [1, x(1), x(1)^2;
     1, x(2), x(2)^2;
     1, x(3), x(3)^2];
b = [y(1); y(2); y(3)];
coeff = A\b;
a = coeff(1);
b = coeff(2);
c = coeff(3);
plot(x,y, 'ro')
hold on
y = a + b.*x +c.*x.^2;
plot(x,y,'b');
xlabel('x values');
ylabel('y values');
title('Best fit Line');
legend('Line of best fit','y fit','data');

end