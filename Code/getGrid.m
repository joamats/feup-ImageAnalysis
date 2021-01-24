function [gridMask, finalMask] = getGrid(imIN, imGT)

% Produce the mask of the grid zone in the RBG Image
% INPUT: RGB Image and Ground Truth Image
% OUTPUT: Mask of the left and top sides of the square and Mask of the
% complete grid

%Get Grids Mask
gridMask = imIN(:,:,2);                                 % Green channel
gridMask = imclose(gridMask,strel('square', 29));       % Close Filter to put 3 lines together
gridMask = imbinarize(gridMask, graythresh(gridMask));  % Otsu Threshold, get rid of cells
gridMask = ordfilt2(gridMask, 1, ones(5,5));            % Min filter, get rid of small fragments & noise
gridMask = imclose(gridMask, strel('square', 30));      % Close to strengthen thick lines      
gridMask = imopen(gridMask, strel('square',30));        % Clean all thin lines
gridMask = imdilate(gridMask, strel('square',15));      % Dilate large lines
gridMask = imclose(gridMask, strel('square', 50));      % Re-close to repair damages in thick lines
gridMask = logical(gridMask);                           % Convert to boolean

% Get ROI positions & translate + crop it
posROI = getROIPosition(imGT);
posROI(1:2) = posROI(1:2) - 15;
posROI(3:4) = posROI(3:4) - 30;

% Get Adapted ROI Mask
s = size(imIN);
roiMask = zeros(s(1:2));
roiMask(posROI(1):(posROI(1) + posROI(3)),posROI(2):(posROI(2) + posROI(4)),:) = 1;

%Join Masks
finalMask = gridMask .* roiMask;
finalMask = imopen(finalMask, strel('square', 30));       % Clean all thin lines at the bottom and right sides

end