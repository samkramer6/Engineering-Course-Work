%9:30TR                4B-25/09/2019                samkramer6
%This script is intended to to a function script to calculate the surface
%area and volume of a solid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
function[Cal] = SAMKRAMER6_Prismareavol(Inp)
        l = Inp(1);%inputs the entries for the vector Inp
        w = Inp(2);
        d = Inp(3);
    vol = w*l*d; %Volume of the prism
    sa = 2*((w*l)+(l*d)+(l*w)); %Surface area of the prism
        Cal(1) = vol;%Entries of the output vector
        Cal(2) = sa;
end       