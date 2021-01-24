function [corners] = getROICorners(im)

% Calculate the coordenates of each corner of ROI 
% INPUT: ROI Mask
% OUTPUT: Corners of ROI in 4 x 2 Matrix 'corners':
% [supLeft(X)   supLeft(Y)]
% [supRight(X) supRight(Y)]
% [infLeft(X)   infLeft(Y)]
% [infRight(X) infRight(Y)]


[r c] = size(im); % size of image

corners1 = detectHarrisFeatures(im, 'FilterSize', 11, 'ROI', [1 1 c/2 r/2] );
corners1 = selectStrongest(corners1, 1);
supLeft = round(corners1.Location);

corners2 = detectHarrisFeatures(im, 'FilterSize', 11, 'ROI', [c/2+1 1 c/2-1 r/2-1]);
corners2 = selectStrongest(corners2, 1);
supRight = round(corners2.Location);

corners3 = detectHarrisFeatures(im, 'FilterSize', 11, 'ROI', [1 r/2+1 c/2-1 r/2-1]);
corners3 = selectStrongest(corners3, 1);
infLeft = round(corners3.Location);

corners4 = detectHarrisFeatures(im, 'FilterSize', 11, 'ROI', [c/2+1 r/2+1 c/2-1 r/2-1]);
corners4 = selectStrongest(corners4, 1);
infRight = round(corners4.Location);

corners = [supLeft; supRight; infLeft; infRight];   % Concatenate for output

end

