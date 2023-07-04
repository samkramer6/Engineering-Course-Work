%These are notes 
%User defined functions like sine, cosine, and sqrt(x)
%These make the subprograms of the larger project compatable and easier to
%fit together 
%Most functions need some sort of user input
%function [output arguments] = function_name(input arguments);
%define that it is a function, has to be the first word in the script file
%and it has to be lower case
%A list of output arguments inside the brackets seperated by a comma
%The name of the function followed bu a list of input arguments inside the
%parenthesiss separed by a comma
%Example script
function [area, perimeter] = circle(radius)%this defines the actual function that will be its own memory bank
area = pi*(radius.^2);
perimeter = 2*pi*radius;
end

