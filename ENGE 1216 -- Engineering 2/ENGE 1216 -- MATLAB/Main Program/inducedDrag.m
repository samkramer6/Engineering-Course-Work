function[iDrag] = inducedDrag(liftCoef, AR) %this calculates the 
e = 0.85; %span efficiency factor
iDrag = (liftCoef.^2)/(pi.*AR.*e);
end
