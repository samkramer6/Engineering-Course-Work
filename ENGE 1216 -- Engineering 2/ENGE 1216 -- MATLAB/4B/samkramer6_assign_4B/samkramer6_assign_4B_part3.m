%9:30TR                 4B-09/25/2019           %samkramer6
%This script uses the functions in part 2 to calculate the Surface are and the volume 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Begin Script
clear;clc;format compact;
fprintf('This is a script that will determine the surface area and the volume of 3 types of solids:\n A Right Triangle Cone, \n A Cylinder, \n And a Rectangular Prism. \n')%Tells the user what the script does
obj = input('How many solids would you like to calculate the surface area and the volume for: '); %asks the user to input how many solids there are
j = 0; %Ticker to set the while loop
while j < obj
    solid = input('What type of solid would you like to calculate? Cone, Cylinder, Prism? \n ', 's'); %asks what kind of solid that the user would like to calculate, it is expecting a string input
    if contains(solid, 'Cone')%looks for string input cone
        Inp(1) = input('Input the height of the cone: '); %input the hight and the radius
        Inp(2)= input('Input the radius of the base: ');
        [Cal] = SAMKRAMER6_Coneareavol(Inp); %calls on the correct function
    elseif contains(solid, 'Cylinder') %looks for the string to contain Cylinder
        Inp(1) = input('Input the height of the Cylinder: '); %height
        Inp(2) = input('Input the radius of the base: '); %radius
        [Cal] = SAMKRAMER6_Cylareavol(Inp);%calls on the correct function
    elseif contains(solid, 'Prism') %looks for the string to contain Prism
        Inp(1) = input('Input the length: '); %dimensions of the prism
        Inp(2) = input('Input the width: ');
        Inp(3) = input('Input the depth: ');
        [Cal] = SAMKRAMER6_Prismareavol(Inp);%calls on the function
    end 
    fprintf('The surface area is %4.2f and the volume is %4.2f \n', Cal(2), Cal(1)) %this outputs the surface area and the volume that the user wanted to find
    again = input('The program is done would you like to run again? \n Yes or No? \n', 's'); %This asks the user to see if they want to calculate another solid
    if contains(again, 'Yes') %looks for string to contain Yes
        j = 0; %this makes sure that the ticker is not changed so that another look may occur
    elseif contains(again, 'No') %looks for the string to contain No
        j = obj; %this makes the ticker larger than the accepted value in the while loop therefore ending the loop
        fprintf('The calculations have been completed\n') %tells the user that the loop has completed
    end
end
