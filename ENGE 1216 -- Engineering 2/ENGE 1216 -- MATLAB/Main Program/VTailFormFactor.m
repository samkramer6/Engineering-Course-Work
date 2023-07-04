function[FF4] = VTailFormFactor(tailVThickness,tailVChord) %this function calculates the vertical tail form factor
FF4 = 1+2.*(tailVThickness/tailVChord)+60.*(tailVThickness/tailVChord).^4;
end
