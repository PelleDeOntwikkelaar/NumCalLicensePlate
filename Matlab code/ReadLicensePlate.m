% Pelle Reyniers
% This script is used to extract the license plate out of a picture.
% This is done by following a lot of steps, general control of the whole
% process is done in this script.
clear all;

% Part 1 -------------------- Image Manipulation --------------------

% image name is loaded into the workspace.
imageName='lp4.jpg';
% image manipulation script is used.
imageManipulation;

% Two properties 'BoundingBox' and binary 'Image' corresponding to these
% Bounding boxes are acquired.
Iprops=regionprops(final,'BoundingBox','Image');
% Selecting all the bounding boxes in matrix of order numberofboxesX4;
NR=cat(1,Iprops.BoundingBox);

% Part 2 ------ Starting the search for parts off the license plate ------
% Calling of controlling function.

% Function 'controlling' outputs the array of indices of boxes required 
% for extraction of characters.
r=controlling(NR); 
% Match indices to letters/numbers.
if ~isempty(r) % If succesfully indices of desired boxes are achieved.
    I={Iprops.Image}; % Cell array of 'Image' (one of the properties of regionprops)
    noPlate=[]; % Initializing the variable of number plate string.
    for v=1:length(r)
        N=I{1,r(v)}; % Extracting the binary image corresponding to the indices in 'r'.
        letter=readLetter(N); % Reading the letter corresponding the binary image 'N'.
        while letter=='O' || letter=='0' % Since it wouldn't be easy to distinguish
            if v<=3                      % between '0' and 'O' during the extraction of character
                letter='O';              % in binary image. Using the characteristic of plates in Karachi
            else                         % that starting three characters are alphabets, this code will
                letter='0';              % easily decide whether it is '0' or 'O'. The condition for 'if'
            end                          % just need to be changed if the code is to be implemented with some other
            break;                       % cities plates. The condition should be changed accordingly.
        end
        noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
    end
    fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
    fprintf(fid,'%s\n',noPlate);      % to the text file, if executed a notepad file with the
    fclose(fid);                      % name noPlate.txt will be open with the number plate written.
    

    
else % If fail to extract the indexes in 'r' this line of error will be displayed.
    fprintf('Unable to extract the characters from the number plate.\n');
    fprintf('The characters on the number plate might not be clear or touching with each other or boundries.\n');
end