function [outputIm] = getROI(inputIm)
% Read a RGB image and, with several image processing techniques, achieve a
% binary mask of the Region of Interest
% INPUT: RGB image
% OUTPUT: ROI mask

outputIm = inputIm(:,:,2);                              % Green channel
outputIm = imclose(outputIm,strel('square', 29));       % Close Filter to put 3 lines together
outputIm = imbinarize(outputIm, graythresh(outputIm));  % Otsu Threshold, get rid of cells
outputIm = ordfilt2(outputIm, 1, ones(5,5));            % Min filter, get rid of small fragments & noise
outputIm = imclose(outputIm, strel('square', 30));      % Close to strengthen thick lines      
outputIm = imopen(outputIm, strel('square', 20));       % Clean all thin lines
outputIm = imclose(outputIm, strel('square', 40));      % Re-close to repair damages in thick lines
outputIm = imbinarize(watershed(outputIm));             % Watershed to segment inner rectangle
outputIm = imdilate(outputIm, strel('square',66));      % 66 = best, dilate big frame to reach ideal dimension
outputIm = logical(outputIm);                           % Convert to boolean

end

