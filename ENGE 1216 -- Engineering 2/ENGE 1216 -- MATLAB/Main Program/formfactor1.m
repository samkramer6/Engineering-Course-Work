function[FF1] = formfactor1(d, l) %This function calculates the form factor for the fuselage
FF1 = 1+1.5.*(d/l).^(3/2)+7.*(d/l).^3;
end
