function[para] = parasiteDrag(wettedFuselage, wettedWing, wettedHTail, wettedVTail, FF1, FF2, FF3, FF4, wingArea)
Re1 = 182000;%These calculate the re for all the different sections of the parasite drag
Re2 = 36000;
Re3 = 36000;
Re4 = 36000;
Cf1 = (0.455)/(log10(Re1).^2.58); %this calclates the Cf for the fuselage
Cf2 = (0.455)/(log10(Re2).^2.58); %Cf for the main wing
Cf3 = (0.455)/(log10(Re3).^2.58); %Cf for the horizontal tail
Cf4 = (0.455)/(log10(Re4).^2.58); %Cf for the vertical tail
CD1 = (Cf1.*FF1.*wettedFuselage)/(wingArea); %parasite drag from the fuselage
CD2 = (Cf2.*FF2.*wettedWing)/(wingArea); %parasite drag for the main wing
CD3 = (Cf3.*FF3.*wettedHTail)/(wingArea); %parasite drag for the horizontal tail
CD4 = (Cf4.*FF4.*wettedVTail)/(wingArea); %parasite drag for the vertical tail
para = CD1 + CD2 + CD3 + CD4; %adds them all together to create the total parasite drag
end