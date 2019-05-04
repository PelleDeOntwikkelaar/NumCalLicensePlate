% Pelle Reynierss
% Part 1: imageManipulation
% This script is ustrelDisk1d to manipulated the input image.
% After this script the image will be in a form that can be read and  
% interpreted by the other Matlab scripts later in the project.

% Image manipulation consists of the following steps:
% - Read the image into the system
% - Greyscale the image
% - Remove possible noise
% - Dilate and Errode the image
% - Detect regions of interest in the picture

% -- Image preparation
% Greyscale the image -> custom made greyscale function
[rgbImage,greyImage] = greyscale(imageName); 
% Remove noise -> cpu removal (universal okay), consider gpu removal when
% using a dedicated system.
greyImage=medfilt2(greyImage,[3 3]); 

% -- Edge detection
% The use of strelDisk1el is explained in the report. High level: used for edge
% detection.
strelDisk1=strel('disk',1);
% Image dilation and eroding, use is explained in the report. Both are
% combinend to detect all edges.
greyImageImdilate = imdilate(greyImage,strelDisk1); 
greyImageImErode = imerode(greyImage,strelDisk1); 
% Substraction of the two previous items.
initialEdgeDetection=imsubtract(greyImageImdilate,greyImageImErode); 

% -- Clear edges
% Converting the class to double -> increase brightness -> convert to
% logical values -> become a perfect only edges image.
initialEdgeDetectionDoubleValues=mat2gray(initialEdgeDetection); 
initialEdgeDetectionDoubleValues=conv2(initialEdgeDetectionDoubleValues,[1 1;1 1]); 
initialEdgeDetectionDoubleValues=imadjust(initialEdgeDetectionDoubleValues,[0.5 0.7],[0 1],0.1); 
logicalEdges=logical(initialEdgeDetectionDoubleValues); 

% -- Filter edges and fill areas
% Clearing the image from non interesting edges and fill interesting
% regions.
er=imerode(logicalEdges,strel('line',50,0));
out1=imsubtract(logicalEdges,er);
% Filling 
F=imfill(out1,'holes');
% Thinning the image to ensure character isolation.
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
% strelDisk1lecting all the regions that are of pixel area more than 100.
final=bwareaopen(H,100);


