function [metrics1] = getMetrics1(imGT, imROI)

% Calculate the metrics for Task1: Jaccard Index,
% Max and Mean differences of corners
% INPUT: Obtained ROI and Ground Truth Masks
% OUTPUT: Vector with Jaccard Index, Max and Mean differences of ROI Mask

imCorners = getROICorners(imROI);  % Get corners of our ROI
gtCorners = getROICorners(imGT);   % Get corners of GT 

% Calculate Euclidean Distance for each 1 out of 4 points, between IM & GT
r = 1:4;
dist(r) = double(sqrt((imCorners(r,1) - gtCorners(r,1)).^2 + (imCorners(r,2) - gtCorners(r,2)).^2));

J = jaccard(imROI, imGT);   % Jaccard Index
MAX = max(dist);            % Maximum distance
MEAN = mean(dist);          % Mean distance

metrics1 = [J, MAX, MEAN];  % Concatenate for output

end

