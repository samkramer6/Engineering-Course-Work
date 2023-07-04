%% Linear Algebra exploration
clc 
clear
format compact
%% Singular matrices
A = [1 2; 1 2];
b = [1 ; 2];
x = A\b;

%% Overdetermined matrix
% x = 1
% x = 3
A = [1;
    1];
b = [1;
    3];
x = A\b  %this will return the least squares multiple of the two over determined variables.