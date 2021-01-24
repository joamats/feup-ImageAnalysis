function [posCells] = getGridCells(imIN, imGT)
% Detect cells in RGB image grid and calculate each square location
% Remove possible noise detection
% INPUT: RGB Image and Ground Truth Image
% OUTPUT: 2D Matrix with position of each detected cell in grid

%Get Grid Mask
[gridMask, finalMask] = getGrid(imIN, imGT);

%Get Masked Image
imI = imIN(:,:,1) .* finalMask;
imI = imbothat(imI, strel('disk',15));

% Enhancement
imA = imI - imdilate(imI, strel('disk', 5));
imB = imI + imerode(imI, strel('disk', 5)); 
imX = (imA.*imB); 
imX = 1 - imX;

imX = imfill(imX);
imX = imgaussfilt(imX, 1.4);
imX = imclose(imX,strel('disk',8));
imX = imX + imtophat(imX,strel('disk',9));


% LoG filter for blobs
radii1 = 35;
sigma1 = radii1/sqrt(2);
hsize1 = sigma1*4 + 1;
imX = imfilter(imX, fspecial('log', round(hsize1), round(sigma1)));

T = multithresh(imX, 6);
imX = imquantize (imX, T(6));

% Enhancement
imX = imerode(imX, strel('disk', 10));
imX = bwareaopen(1 - imX, 40);

% Conversions
imX = 1 - imX;
imX(finalMask == 0) = 0; 
imX = logical(imX);

% Blob Detection
hBlob = vision.BlobAnalysis('MinimumBlobArea', 400, 'MaximumBlobArea', 4000);
[oA, oC, bboxOut] = step(hBlob, imX);

oC = round(oC);

r = size(bboxOut,1);
t = 25;
posCells = [];

% posCells save
posCells(:,[1,2]) = oC - t;
posCells(:,[3,4]) = 2*t;

% Assess Intensities
% Get mean intensity of grid
imGrid = imIN(:,:,1) .* gridMask;
M = mean(mean(imGrid(gridMask ~= 0)));
T = 0.17;

rGrid = size(posCells,1);
iToRemove = [];

% Compare mean of intensity of cell and mean
for k = 1:rGrid
    box = round(posCells(k,:));
    mCell = mean(mean((imGrid(box(2) + box(3), box(1) + box(3)))));
    
    if mCell - M >= T    % Brighter objects are removed
        iToRemove(end + 1) = k;     
    end
end 

posCells(iToRemove,:) = [];
posCells = round(posCells);

 end