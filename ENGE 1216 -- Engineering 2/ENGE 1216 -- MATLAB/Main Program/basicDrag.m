function [basicDrag] = basicDrag(wingArea, V, dragCoeff)%This calculates the total drag of the drone
basicDrag = (.567).*(V^2).*(dragCoeff).*(wingArea);
end