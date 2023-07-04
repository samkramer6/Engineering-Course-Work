%9:30TR                4B-25/09/2019                samkramer6
%This script is intended to to a function script to calculate the surface
%area and volume of a solid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
function[Cal] = SAMKRAMER6_Cylareavol(Inp)
    h = Inp(1);%inputs the entries for the vector Inp
    r = Inp(2);
    sa = (2*pi*r*h)+(2*pi*(r^2)); %Surface area
    vol = pi*(r^2)*h; %Volume
    Cal(1) = vol;
    Cal(2) = sa;
end