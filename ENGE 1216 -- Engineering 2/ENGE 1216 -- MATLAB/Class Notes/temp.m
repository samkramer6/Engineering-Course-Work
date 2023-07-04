function [fah] = temp(celcius)%You can input multiple and put it into a vector but you just have to enter the expected inputs as a vector
fah = 32 + celcius.*(9/5);
end
%End of the function code
% If you want to put in a matrix, you need to have the element definition
% first so like: Vec(1) = fah Vec(2) = celcius