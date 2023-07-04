%false position method
    %From ME2004 Homework 4 question 1 d)
function [root,roots,xus,xls] = FalsePosition(y, xu, xl, itNum)
%
%Inputs:    y   = function we are finding the root for [function]
%           xu  = upper guess of the root [scalar]
%           xl  = lower guess of the root [scalar]
%           itNum = Number of iterations desired [scalar]
%

roots = zeros(itNum, 1);
xus = zeros(itNum,1);
xls = zeros(itNum,1);
root = xu - y(xu)*((xu-xl)/(y(xu) - y(xl)));
    for i = 1:itNum
        xls(i) = xl;
        xus(i) = xu;
        root = xu - y(xu)*((xu-xl)/(y(xu) - y(xl)));
        if y(xl)*y(xu) < 0
            if y(xl)*y(root) <0
                xu = root;
            else
                xl = root;
            end
        else
            break
        end
    roots(i) = root;
    end   
end