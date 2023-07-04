%9:30TR          Take Home Exam part 2 10/15/2019              samkramer6
%This will call on a certain image and then it will take that image and
%convert it to greyscale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin script
clear;clc;format compact;
a = input('please input the name of the photo: ', 's');%asks user to input the name of the picture
data = imread(a);%reads the picture and creates a matrix
alpha = size(data,1);%counts the number of rows in the column
result = reshape(data,alpha,[]);%resizes the matrix to be easier to work with
bravo = size(result,2);%counts the number of columns in the matrix
charlie = bravo/3;%properly resizes the amount of columns
[greyscale] = samkramer6_greyscale(alpha, charlie, result);%Function 1
[greyscale2] = samkramer6_greyscale_2(alpha, charlie, result);%function 2
figure(1);%creates all the figures
imshow(a)
figure(2);
imshow(greyscale)
figure(3);
imshow(greyscale2);



    
 

