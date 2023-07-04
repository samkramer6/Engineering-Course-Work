%9:30TR                 4B-09/25/2019           %samkramer6
%This script is a user input code that asks for the input and uses those
%inputs to calculate 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Begin Script
clear;clc;format compact; %Clears the window and everything else so that the calculations are not affected
fprintf('This is a script that will determine the surface area and the volume of 3 types of solids:\n A Right Triangle Cone, \n A Cylinder, \n And a Rectangular Prism. \n')%Tells the user what the script does
obj = input('How many solids would you like to calculate the surface area and the volume for: '); %asks the user to input how many solids there are
j = 0; %Ticker to set the while loop
while j < obj
    solid = input('What type of solid would you like to calculate? Cone, Cylinder, Prism? \n ', 's'); %asks what kind of solid that the user would like to calculate, it is expecting a string input
    if contains(solid, 'Cone')%looks for string input cone
        h = input('Input the height of the cone: '); %input the hight and the radius
        r = input('Input the radius of the base: ');
        vol = pi*(r^2)*(h/3); %calculate volume
        sa = pi*r*(r+sqrt((h^2)+(r^2))); %calculate the Surface Area
    elseif contains(solid, 'Cylinder') %looks for the string to contain Cylinder
        h = input('Input the height of the Cylinder: '); %height
        r = input('Input the radius of the base: '); %radius
        sa = (2*pi*r*h)+(2*pi*(r^2)); %Surface area
        vol = pi*(r^2)*h; %Volume 
    elseif contains(solid, 'Prism') %looks for the string to contain Prism
        l = input('Input the length: '); %dimensions of the prism
        w = input('Input the width: ');
        d = input('Input the depth: ');
        vol = w*l*d; %Volume of the prism
        sa = 2*((w*l)+(l*d)+(l*w)); %Surface area of the prism
    end 
    fprintf('The surface area is %4.2f and the volume is %4.2f \n', sa, vol) %this outputs the surface area and the volume that the user wanted to find
    again = input('The program is done would you like to run again? \n Yes or No? \n', 's'); %This asks the user to see if they want to calculate another solid
    if contains(again, 'Yes') %looks for string to contain Yes
        j = j; %this makes sure that the ticker is not changed so that another look may occur
    elseif contains(again, 'No') %looks for the string to contain No
        j = obj; %this makes the ticker larger than the accepted value in the while loop therefore ending the loop
        fprintf('The calculations have been completed\n') %tells the user that the loop has completed
    end
end

    
    
 
        
        
        

