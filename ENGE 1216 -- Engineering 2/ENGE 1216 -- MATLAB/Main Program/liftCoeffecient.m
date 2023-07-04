function[liftCoef] = liftCoeffecient(droneMass, V, wingArea)%this will calculate the total lift coefficient of the drone
droneWeight = (droneMass.*9.81); %calculates the total drone weight in newtons
liftCoef = (2.*droneWeight)/(1.134.*(V.^2).*wingArea);
end