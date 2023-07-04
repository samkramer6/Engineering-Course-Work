%loops like while loops repeat an action as long as a condition is true
clear;clc;format compact;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%how to use the for loops
%to go to a new line use "fprintf(' \n')"
for j= 1:7 %for j equals 1 to 7. it is so much cleaner
    disp('matlab sucks')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%nested loop struture
%write one loop and put another loop inside of it
%for loop
%for t = 1:h
%   for u = 1:i
%        <statements>;
%    end
%end
%build out a matrix this way
%%%%%%while loops
%while <expression1>
%    while <expression2>
%        <statements>;
%    end 
%end
%fprintf formats data and displays the results on the screen
%fprintf puts in the different variables using the %f feature
%%s uses different string results. s=the amount of characters in the
%string
%The %f uses the amount of numbers in the entry then numbers after the .
%means the amount of spaces after the decimal
%%d uses the 