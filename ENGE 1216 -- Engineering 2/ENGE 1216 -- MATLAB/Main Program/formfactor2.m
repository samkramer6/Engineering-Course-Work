function[FF2] = formfactor2(t,c) %This calculates the form factor for the wing
FF2 = 1+2.*(t/c)+60.*(t/c).^4;
end
