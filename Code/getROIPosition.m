function [position] = getROIPosition(im)

% Find the coordinates for the ROI region in each image
% INPUT: 2D matrix with grayscale image
% OUTPUT: Matrix with the y and x coordinates of the first white pixel
% and the height and length of the ROI region, for each image
% each row of the matrix contains: (y, x, height, length)

position = zeros(1,4);          %initialize matrix for coordinates of ROI

corners = getROICorners(im);    %get corners' coordinates

%save "row" coordinate of top left corner
position(1) = min(corners(1,2),corners(2,2)); 
%save "column" coordinate of top left corner
position(2) = min(corners(3,1),corners(1,1)); 
%save maximum height of ROI
position(3)= max(corners(4,2)-corners(2,2),corners(3,2)-corners(1,2))+1; 
%save maximum length of ROI
position(4) = max(corners(2,1)-corners(1,1),corners(4,1)-corners(3,1))+1; 

end
