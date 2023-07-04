% ME 3534 Homework #7
clear; clc; format compact; close all

% -- Part a) K = 10

k = 10;

z = [];
p = [0 -1 -5];

Hf = zpk(z,p,k)

P = bodeoptions;
P.FreqUnits = 'Hz';
bode(Hf,P)
    grid on
   
% -- Part b) K = 100   
    
k = 100;

z = [];
p = [0 -1 -5];

Hf = zpk(z,p,k)

figure
P = bodeoptions;
P.FreqUnits = 'Hz';
bode(Hf,P)
    grid on
