%9:30TR                4B-25/09/2019                samkramer6
%This script is intended to to a function script to calculate the surface
%area and volume of a solid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
function[Cal] = SAMKRAMER6_Coneareavol(Inp)
    h = Inp(1);%inputs the entries for the vector Inp
    r = Inp(2);
    vol = pi*(r^2)*(h/3); %calculate volume
    sa = pi*r*(r+sqrt((h^2)+(r^2))); %calculate the Surface Area
    Cal(1) = vol;
    Cal(2) = sa;
end
