%This is the actual script, this uses the function that we made and then
%uses the input in the question and calculates it.
clear;clc;format compact
radius = input('input the radius: ');
[area, perimeter] = circle(radius);%This generates the area and perimeter of a given circle using the inputted radius 
diameter = radius*2; %calculates the diameter. The phrase circle() is the name of the function script that the computer will use to calculate the data. They are different scripts, not in the same script.
fprintf('The diameter, perimeterm and the area of the given cirvle, respectively are: \n%7.2f, %7.2f, %7.2f\n',diameter:perimeter:area) 
%use fprintf because it is a function being printed