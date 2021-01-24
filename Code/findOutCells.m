function [iToRemove] = findOutCells(posCells, mask)
% Find cells outside ROI, to be removed
% INPUT: 2D matrix with cells' positions and mask with the grid
% OUPUT: Indexes of cells to remove

r = size(posCells,1);

iToRemove = []; % vector with out cells indexes

for i = 1:r
    cY = posCells(i,2) + round(posCells(i,3)/2);
    cX = posCells(i,1) + round(posCells(i,3)/2);
   if mask(cY, cX) == 0
       iToRemove(end + 1) = i;
   end     
end

end

