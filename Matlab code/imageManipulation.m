% Pelle Reynierss
% Step 1: imageManipulation
% This script is ustrd to manipulated the input image.
% After this script the image will be in a form that can be read and  
% interpreted by the other Matlab scripts later in the project.

% Image manipulation consists of the following steps:
% - Read the image into the system
% - Greyscale the image
% - Remove possible noice
% - Dilate and Errode the image
% - Detect regions of interest in the picture

% greyscale the image -> custom made greyscale function
[rgbImage,greyImage] = greyscale(imageName); 
% noice removal normal way,
% todo: consider removal while making ustr of the GPU
greyImage=medfilt2(greyImage,[3 3]); 
% Structural element (disk of radius 1) for morphological processing.
% todo: write a lot about strel in the report: very interesting
str=strel('disk',1);

% Dilating the grey image with the structural element.
greyImageImdilate=imdilate(greyImage,str); 
% Eroding the grey image with structural element.
greyImageE=imerode(greyImage,str); 

% Morphological Gradient for edges enhancement.
% This means combining the two previous items.
gdiff=imsubtract(greyImageImdilate,greyImageE); 

% Converting the class to double.
gdiffDouble=mat2gray(gdiff); 
% Convolution of the double image for brightening the edges.
gdiffDouble=conv2(gdiffDouble,[1 1;1 1]); 
% Intensity scaling between the range 0 to 1.
gdiffDouble=imadjust(gdiffDouble,[0.5 0.7],[0 1],0.1); 
% Conversion of the class from double to binary. 
B=logical(gdiffDouble); % Conversion of the class from double to binary. 

% Eliminating the possible horizontal lines from the output image of regiongrow
% that could be edges of licenstr plate.
er=imerode(B,strel('line',50,0));
out1=imsubtract(B,er);
% Filling all the regions of the image.
F=imfill(out1,'holes');
% Thinning the image to ensure character isolation.
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
% strlecting all the regions that are of pixel area more than 100.
final=bwareaopen(H,100);


