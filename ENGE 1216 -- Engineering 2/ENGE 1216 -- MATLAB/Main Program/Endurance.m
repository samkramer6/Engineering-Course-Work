function[endurance] = Endurance(dragAtMax, maxSpeed) %This function calculates the endurance of the drone
endurance = (((31968)*(0.8))/(dragAtMax.*maxSpeed))/3600;
end
