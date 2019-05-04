% Pelle Reyniers
% Function used to greyscale an rescale and greyscale an image.
% Funciton returns resized colored and greyscaled image.

function [rgbImage,greyImage] = greyscale(inputFileName)
try
    % read input image
    [X,map] = imread(inputFileName);
    figure
    imhist(X)
    % transform input image to rgb if needed.
    if ~isempty(map)
        rgbImage = ind2rgb(X,map);
    else
        rgbImage = X;
    end
    rgbImage=imresize(rgbImage,[600 NaN]); % Resizing the image.
    [rows, columns, numberOfColorChannels] = size(rgbImage);
    if numberOfColorChannels  == 3 % this doesn't work with RGBa
        % split the different color channels
        redChannel = rgbImage(:, :, 1);
        greenChannel = rgbImage(:, :, 2);
        blueChannel = rgbImage(:, :, 3);
        % make grayscale image
        greyImage = .299*double(redChannel) + ...
                    .578*double(greenChannel) + ...
                    .114*double(blueChannel);
        % Backscale using unint8 for readebility.
        greyImage = uint8(greyImage);
        figure
        imhist(greyImage)
    else
        % image isn't RGB -> return input image.
        greyImage = rgbImage; 
        figure
        imhist(greyImage)
    end
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
    ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(warndlg(errorMessage));
end
end