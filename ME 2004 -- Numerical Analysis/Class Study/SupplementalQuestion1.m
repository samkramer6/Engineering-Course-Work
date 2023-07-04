%% setup section
clear; clc; format compact; close all;
a = 1;
b = 9;  %Upper limit
x = a:0.1:b;    %x-value matrix

figure;
plot(x, f(x));
grid on;
xlabel('x (ND)');
ylabel('y (ND)');
title('Figure 1: Unknown Function {\itf(x)}');



