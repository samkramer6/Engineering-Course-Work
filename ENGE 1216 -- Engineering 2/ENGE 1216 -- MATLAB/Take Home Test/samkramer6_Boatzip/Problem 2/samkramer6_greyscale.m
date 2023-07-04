function[greyscale] = samkramer6_greyscale(alpha, charlie, result)
j = 1;
y = 1;
horizontal = []; 
for j = (1:1:alpha)  
    for y = (1:1:charlie)
        greyscalea = ((result(j,y)/3)+30); %takes each individual pixel and converts it to grey scale
        horizontal(j,y) = greyscalea; %places that pixel into a new matrix
    end
    y = 1;%resets the loop
end
greyscale = uint8(horizontal);%converts the matrix into uint format so that it can be displayed
end