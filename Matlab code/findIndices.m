function out=findIndices(input)
% Function findIndices gets as an input a vector with container information.
% This information contains location and size of the containers containing
% the interesting regions in the image. This function will make an educated
% guess on which containers are probably part of the license plate an which
% containers probably aren't.
% The output values is an array with indices of the corresponding
% intersting containers.

