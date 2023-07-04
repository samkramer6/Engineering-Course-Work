%% Step function plotting
x = -1:0.01:3;
a = 0;
Sf = x >= a;
plot(x, Sf, 'r')

%% Volume calculations
r = 20;
d = 61;
if d > 3*r
    Vol = "overtop \n";
end
fprintf(Vol);

%% Integral Calculation
clc;
x = [0 0.1 0.3 0.5 0.7 0.95 1.2];
y = [1 0.9048 0.7408 0.6065 0.4966 0.3867 0.3012];
a = length(x) - 1;
val = 0;
func = @(x) 2.7182.^(-x);
for i = 1:a
    val = val + (1/2)*(x(i+1) - x(i))*(y(i) + y(i+1));
end
disp(val);
valP = integral(func,0,1.2)
err = (val - valP)/valP;


%Syntax for a consistent step size trapezoid approx.
valLog = (.171428)*(.5)*(sum(y) + sum(y) - y(1) - y(length(y)))
