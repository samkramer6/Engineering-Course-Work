function [] = BFLCalculator(A,xEval)
%BESTFITLINE        This is a function that will be able to calculate the
%                   line of best fit and also calculate the value of the
%                   line of best fit at the position along the x axis.
%
%Inputs:            A = Matrix of data we are trying to fit [Matrix]
%                   xEval = x value that we would like to evaluate the line
%                           of best fit on. [Scalar]
%

x = A(:,1);
y = A(:,2);
plot(x,y, 'o');
hold on
P = polyfit(x,y,2);
plot(x,y,'b');
hold on
mu_fit = polyval(P,xEval);
a1 = P(1);
a2 = P(2);
a3 = P(3);
plot(xEval, mu_fit,'o');
xlabel('x values');
ylabel('y values');
title('Best fit Line');
legend('data','line of best fit','mu fit');
fprintf('Line of best fit is y = %3.3f x^2 + %3.3f x + %3.3f \n', a1, a2, a3);
end