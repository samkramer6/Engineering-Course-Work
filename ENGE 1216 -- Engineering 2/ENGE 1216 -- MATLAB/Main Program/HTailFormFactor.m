function[FF3] = HTailFormFactor(tailHThickness,tailHChord)%this function calculates the form factor for the horizontal tail
FF3 = 1+2.*(tailHThickness/tailHChord)+60.*(tailHThickness/tailHChord).^4;
end
