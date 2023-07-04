%fprintf can be used to save output to a file in addition to displaying 
%three steps 
    %step one, needs to open a file before data can be saved to the file
    %with fopen command 
        % fid = fopen('filename' , 'permission')
            % permissions:
                %'r' is for reading 'w' is for writing 'a' is the same as w
                %but if the file exists append data to the end of the file
    %step two, use fprintf command to format and write to fild 
        % fprintf(fid, 'text %5.2f more text', variable)
    %step 3 close the file with fclose command
        % fclose(fid)

%loading data 
%We have been using the input command 
%if we add a ,'s' at the end of the input command it is expecting a string
%we could uses fprintf to output the string now
%We could use the load command 
    %we can load large data sets into a script and working with multiple
    %data sets
%load command is how we will do it
%method 1
    % load datafile.txt
%Method 2
    % A = load('datafile.txt')
        %This way We dont have to use the long variable name
%Method 3
    % A = input('type the files name: ', 's')
        %asks the user to cose the file name to be loaded, the 's'
        %indicates the file name as a string and saves the string as a
        %variable
    % data = load(A)
%Structure requirements for the load file
%cannot use load if a file has headers. it will interpret it as 2 different
%data types and would try and make 2 matrices into one
%Loaded files can only contain numenrical values. Cannot have any comments
    %in it
%Some file types have special commands to load them, we will not look at
%them in class.

%Modeling
%Variance is the square root of the standard deviation