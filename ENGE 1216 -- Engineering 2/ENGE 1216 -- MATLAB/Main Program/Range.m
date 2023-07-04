function[range] = Range(dragAtMax, droneMass, mBatt) %This function calculates the total range of the drone
droneWeight = (droneMass.*9.81);%This calculates the weight in newtons for the drone
range = (360000.*(mBatt/droneMass).*(1/(9.81)).*((droneWeight)/dragAtMax).*(.08))/(160.934);
end