%9:30TR                        10/1/2019                       samkramer6
%This code will calculate the amount of times that two boats get within 2
%boat lengths of eachother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
clear;clc;format compact; 
%this loads the actual .csv file
a = input('Input the file name: ', 's');
data = load(a);
%this sets all the columns of the .csv file to be equal to a matrix that is
%used in the user defined function to calculate the distance
time = data(:,1);%time 
lat1 = data(:,2);%latitude of boat one
lon1 = data(:,3);%longitude of boat one
lat2 = data(:,4);%latitude of boat two
lon2 = data(:,5);%longitude of boat two
k = 1; %these are used in the ticker variable
d = 0; %this variable is the amount of tiems that the boats come within 54 m of eachother
while k < numel(time)%This is the while loop that will calculate how many times that the boats come within 2 boat lengths of eachother
    [mApart] = distance(lat1, lat2, lon1, lon2);%Calling on the user defined function
    q = k-1; %this is necessary because we need to do the last value in the matrix to see if it  was greater than 54
    if q~=0 %q must equal an integer because there is no zeroth entry of the vector mApart
        if mApart(q) > 54.00 && mApart(k) <= 54.00 %this calculates if it is actually changing from being outside of 54 meters to within
          d = d+1;
        end
    end
       k = k + 1; %adds one to the ticker
end
%This displays the amount of times and then also makes a new .txt document
%that displays the amount of times that they come close together
clc;%clears the command window just to clean things up.
fprintf('The amount of times that the boats came within 54 meters of eachother was %4.2f times. \n', d)
fid = fopen('boatsclose2.txt', 'w');
fprintf(fid, 'The amount of times that the boats came within 54 meters of eachother was %4.2f times.', d);
fclose(fid);
%This is the part that will now plot the time vs. distance graph
title('Plot of Race Boat Seperation as a Function of Time');%Labels the x,y, and title of the plot
xlabel('Time(s)');
ylabel('Boat seperation distance(m)');
plot(time, mApart, '-b'); %this plots the graph 