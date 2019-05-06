% Pelle Reyniers
% This script is used to extract the license plate out of a picture.
% This is done by following a lot of steps, general control of the whole
% process is done in this script.
clear all;

% Part 1 -------------------- Image Manipulation --------------------

% image name is loaded into the workspace.
imageName='pic4.jpg';
% information about the license plate
totalCharacters = 6;
letters= 3;
% image manipulation script is used.
imageManipulation;

% The funciton regionprops returns information about the containers with
% capturing interesting regions in the picture.
% Boundingbox: info about the container
% Image: image for all the containers
ImageContainers=regionprops(final,'BoundingBox','Image');
ICMatrix=cat(1,ImageContainers.BoundingBox); % Matrix conversion

% Part 2 ------ Starting the search for parts off the license plate ------
Images={ImageContainers.Image}; 
[plates,corrs]=findIndices(ICMatrix, totalCharacters, letters,Images);

if ~isempty(plates) 
    
    [M, I]=max(corrs);
    licensePlateInt=plates(:,I);
    licensePlateInt=licensePlateInt';
    
    fid = fopen('licensePlate.txt', 'wt'); 
    fprintf(fid,'%s\n',licensePlateInt);      
    fclose(fid);                      
    
else
    fprintf('Operation failed, the characters could not be matched to make a correct license plate.\n');
end

% Part 3 ------ End of the script, evaluation of result manually ------