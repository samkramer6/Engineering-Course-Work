function [dynamicThrust] = Dthrust(V) %This calculates the thrust of the drone
dynamicThrust = 3.548 - 0.186.*V;
end