function [posCells] = getCells(imIN, imGT)
% Detect cells in RGB image and calculate each square location
% Remove possible duplicates in each detected cell
% INPUT: RGB Image and Ground Truth Image
% OUTPUT: 2D Matrix with position of each detected cell

% Get ROI positions & translate + crop it
posROI = getROIPosition(imGT);

posROI(1:2) = posROI(1:2) - 30;
posROI(3:4) = posROI(3:4) - 15;

%Ensure image limits are not exceeded
if(posROI(1)<=0)
    posROI(1)=1;
end
if(posROI(2)<=0)
    posROI(2)=1;
end

% Get Adapted Mask
s = size(imIN);
mask = zeros(s(1:2));
mask(posROI(1):(posROI(1) + posROI(3)),posROI(2):(posROI(2) + posROI(4)),:) = 1;

% Get  Masked Image
im = imIN .* mask;

% Cell Enhancement
imC = im(:,:,1);
imC = medfilt2(imC, [9 9]);
imC = imbothat(imC, strel('disk',5));
imC = medfilt2(imC, [7 7]);
imC = imclose(imC, strel('disk', 5));
imC = imopen(imC, strel('line', 5, 0));
imC = medfilt2(imC, [5 5]);

% Histogram Stretching
imC = imadjust(imC, [0.01 0.04], [0 1], 0.8);

% Edge Detection
imC = edge(imC,'nothinning'); 
imC = medfilt2(imC, [4 4]);

for k = 0:20:180
    
    imC = imclose(imC, strel('line', 5, k));
    
end

% Circle Detection
[center, radii] = imfindcircles(imC, [20 50]); 
r = size(center,1);
t = 2;  % Margin for rectangle
posCells = [];

% Draw Rectangles for each cell
for i = 1:r
        topCorner = center(i,:) - radii(i);
        len = 2*radii(i) + 2*t;
        posCells(i,:) = round([topCorner - t,len, len]);
end

%Get Grid Cells
posGridCells = getGridCells(imIN, imGT);
posCells = [posCells; posGridCells];

% Eliminate Cells with Center outside Grid
[gridMask, finalMask] = getGrid(imIN, imGT);
iToRemove = findOutCells(posCells, gridMask | imGT);
posCells(iToRemove, :) = [];

% Eliminate repeated cells
iToRemove = findDuplicates(posCells);
posCells(iToRemove,:) = []; 

end

