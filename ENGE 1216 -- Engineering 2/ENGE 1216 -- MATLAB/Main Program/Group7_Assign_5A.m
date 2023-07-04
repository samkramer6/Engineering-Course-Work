%9:30TR                 5A-10/27/19                  Group 7 samkramer6
%This code will ask the user to input the dimensions of the plane
%prototype, and the wind vector. It will then output the drone weight, the
%total theoretical wing area, and the wing span. It will also calculate the
%fastest speed that the prototype can fly, and will also calculate the
%range and endurance of the prototype.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
clear;clc;format compact
%given information
pitch = .0762; %propeller pitch is 3 inches
dprop = 0.1542; %diameter of the propeller is 6 inches
RPM = 15000;
thrust = [];
drag = [];
K = [.5:.1:40];
j = 1;
q = j - 1;
%Inputs of the measurements of the drone:
fprintf('Put all of your measurements in SI units(meters, kg). \n')%this statement determines the units for the calculations
wingArea = input('Please input the wing area of your drone: '); 
wingSpan = input('Please input the wing span of your drone: ');
t = input('Please input the wing thickness: '); %This is the input for the main wing thickness
wettedWing = input('Please input the wetted area of the wing: ');
wettedFuselage = input('Please input the wetted area of the fuselage: ');
wettedVTail = input('Please input the wetted area of the vertical tail: ');
wettedHTail= input('Please input the wetted area of the horizontal tail: ');
d = input('Please input the average diameter of the fuselage: '); %This is the main input for the diameter of the fuselage
l = input('Please input the length of the fuselage: '); %Asks user to input the length of the fuselage
tailHThickness = input('Please input the thickness of the horizontal tail: ');
tailVThickness = input('Please input the thickness of the vertical tail: ');
c = input('Please input the chord of the wing: '); %this is the overall chord of the main wing
tailHChord = input('Please input the chord of the horizontal tail: ');
tailVChord = input('Please input the chord of the vertical tail: ');
droneMass = input('Please input the mass of the drone: '); %mass of the drone, wll be converted to weight later in the script
mBatt = input('Please input the mass of the battery: ');%mass of the battery
for V = .5:.1:40
%Begin calculations:
    %Dynamic Thrust calculations: 
[dynamicThrust] = Dthrust(V);
thrust = [thrust dynamicThrust]; %his is meant to create a thrust vector which will be plotted versus velocity
    %lift Coeffecient:
[liftCoef] = liftCoeffecient(droneMass, V, wingArea);
    %aspect Ratio calculations: 
[AR] = aspectRatio(wingSpan, wingArea);
    %Form Factor 1 calculations:
[FF1] = formfactor1(d, l);
    %Form Factor 2 calculations:
[FF2] = formfactor2(t,c);
    %Horizontal Tail Form Factor calculations:
[FF3] = HTailFormFactor(tailHThickness,tailHChord);
    %Vertical Tail Form Factor calculations:
[FF4] = VTailFormFactor(tailVThickness,tailVChord);
    %Induced drag calculations: 
[iDrag] = inducedDrag(liftCoef, AR);
    %Parasite Drag calculations:
[para] = parasiteDrag(wettedFuselage, wettedWing, wettedHTail, wettedVTail, FF1, FF2, FF3, FF4, wingArea);
parasite = para;
    %calculating drag coeffecient:
[dragCoeff] = dragCoeffecient(parasite, iDrag);
    %calculating the drag
basicDrag = (.567).*(V^2).*(dragCoeff).*(wingArea);
drag = [drag basicDrag]; %This is the drag vector that will be calculated versus the velocity
    if q ~= 0 %this is the number entry of the two vectors, it says that it cannot be zero
        if drag(j) <= thrust(j) %if the current vector entry had a larger thrust force
            if drag(q) <= thrust(q)%and if the last vector entry had a larger thrust force
                maxSpeed = V; %Then the current value of V is the fastest velocity
                dragAtMax = basicDrag; %and the value of the basic drag is the drag at the maximum velocity
            end
        end
    end
 j=j+1; %These 2 lines add to the tickers
 q=q+1;
end
%This section calculates the range and endurance of the drone
    %range
        [range] = Range(dragAtMax, droneMass, mBatt);
    %endurance
        [endurance] = Endurance(dragAtMax, maxSpeed);
%This section displays the maximum speed that the drone can fly
fprintf('The maximum speed that your drone can go is %3.3f m/s. \n the maximum range is %3.3f miles and the maximum endurance is %3.3f hrs. \n', maxSpeed, range, endurance)
%This section sets up the graphing portion of the deliverables
plot(K, thrust, 'b') %Plots the value of thrust versus each value of velocity that was entered
hold on
plot(K, drag, 'r') %plots the drag vector against each value of velocity that was entered
hold on
grid on %puts the grid of the plot on 
xlabel('speed') %labels the axes
ylabel('force')
title('What is the fastest that the drone can fly')%Titles the 
hold on
%This section creates a table from the inputs that are given:
format compact
fprintf('Table displaying values of the plane: \n\n') %Labels the table output so the user understands what is displayed
t = table(d,droneMass,l,wingArea,wingSpan); %sets up the table that will display the following variabls
t.Properties.VariableNames = {'Fuselage_Diameter', 'Drone_Weight', 'Fuselage_Length', 'Wing_Area', 'Wing_Span'}; %Renames the columns of the table to have more understandable names
disp(t)%displays the table that was created