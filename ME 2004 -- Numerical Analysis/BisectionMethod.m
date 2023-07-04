%bisection function for finding roots of functions
    %From ME2004 Homework 4 question 1 c)
function [root, roots, xus, xls] = BisectionMethod(y, xu, xl, itNum)
%
%Inputs:    y     = function we are trying to find the roots for [Function]
%           xu    = upper guess [scalar]
%           xl    = lower guess [scalar]
%           itNum = number of iterations desired [scalar]
%
%Outputs:   root  = root calculated [scalar]
%           roots = vector quantity of the estimated root after each
%                   iteration [Vector]
%           xus   = vector quantity of the upper guess estimates after each
%                   iteration [vector]
%           xls   = vector quantity of the lower guess estimates after each
%                   iteration [vector]
%
roots = zeros(itNum, 1);
xus = zeros(itNum,1);
xls = zeros(itNum,1);
root = (xu + xl)/2;
    for i = 1:itNum
        xls(i) = xl;
        xus(i) = xu;
        root = (xu + xl)/2;
        if y(xl)*y(xu) < 0
            if y(xl)*y(root) < 0
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