%9:30TR           Take Home Practical-10/15/2019            samkramer6
%This script will call upon a user defined script and then calculate the
%average speed, the total distance traveled, and the minimum and maximum
%instantaneous speeds and then the standard deviation over the course of
%the race
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
clear; clc; format compact;
%data loading section
y = input('Input the file name: ','s');
data = load(y);%loads the data
time = data(:,1);%Creates each of the columns of the data into a vector
lat = data(:,2);
lon = data(:,3);
lastLon = lon(end);
lastLat = lat(end);
%function call section
%calculating distance traveled
[dist] = samkramer6_DistFunction(lat, lon, lastLon, lastLat);
dista = dist/1000;
%calculating the average velocity

totTime = time(length(time));
avgVel = (dist/totTime);
%Maximum and Minimum instantaneous velocity
j = 2;
q = j-1;
instVel = [];
maxInsta = 0;
minInsta = 900;
while j < numel(lat)
        lat1 = (lat(j)*pi)/180;%This converts the readings into radians
        lat2 = (lat(q)*pi)/180;
        lon1 = (lon(j)*pi)/180;
        lon2 = (lon(q)*pi)/180;
        Dlat = lat2 - lat1;
        Dlon = lon2 - lon1;
            R = 6371000; %must be in meters to compute the distance between the boats in meters
            a = (sin(Dlat/2)).^2 + cos(lat1).*cos(lat2).*(sin(Dlon/2)).^2;
            c = 2*atan2(sqrt(a),sqrt(1-a));
            mTrav = R*c;
        tDif = time(j) - time(q); %calculates the time difference
        instVela = mTrav/tDif; %calculates the instantaneous speed
        instVel = [instVel instVela];
        j = j+1;
        q = q+1;
end
h = 2;
k = 1;
while k < numel(instVel)
    if instVel(h) > maxInsta %calculates the maximum instantaneous velocity
        maxInsta = instVel(h);
    end
    if instVel(h) < minInsta %calculates the minimum instantanoeus velocity
        minInsta = instVel(h);
    end
    h = h+1; 
    k = k+1;
end
%%Standard Deviation
z=1;
add1 = 0;
add2 = 0;
while z < numel(instVel)%takes the sum of the vector
    add1 = (instVel(z) + add1);
    z=z+1;
end
    mean1 = (add1/numel(instVel));%finds the mean
    stdB = instVel - mean1;%subtracts the mean from the vector
    stdC = stdB.^2;%squares the difference
v = 1;
while v <= numel(instVel)%
    add2 = (stdC(v) + add2);%finds the sum of this vector
    v = v+1;
end
mean2 = (add2/numel(instVel));%fnds the mean of the sum of the difference vector
stdDev = sqrt(mean2); %square roots it to find the standard deviation
%display the functions
fprintf('Over the course of the race the average speed was %5.3f m/s, and the total distance traveled was %5.3f km, the maximum instantaneous \nspeed was %5.3f m/s, and the minimum instantaneous speed was %5.3f m/s, and the standard deviation was %5.3f\n', avgVel, dista, maxInsta, minInsta, stdDev)
fid = fopen('samkramer6_RaceData.txt', 'w');
fprintf(fid, 'Over the course of the race the average speed was %5.3f m/s, and the total distance traveled was %5.3f km, the maximum instantaneous \nspeed was %5.3f m/s, and the minimum instantaneous speed was %5.3f m/s, and the standard deviation was %5.3f\n', avgVel, dista, maxInsta, minInsta, stdDev);
fclose(fid);