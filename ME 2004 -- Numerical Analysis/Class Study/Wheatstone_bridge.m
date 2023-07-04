function cur = Wheatstone_bridge(V, R)

%inputs
%R = vector of Rs
%outputs
%Create A Matrix
A = [0 R(2) 0 R(4) 0 0;
    R(1) -R(2) R(3) 0 0 0;
    0 0 -R(3) -R(4) R(5) 0;
    1 1 0 0 0 -1;
    0 1 1 -1 0 0;
    1 0 -1 0 -1 0];
    
%Create B Matrix
b = zeros(6,1);
b(1) = V;
%Solve for currents using backslash\
cur = A\b;

end