function [iToRemove] = findDuplicates(posCells)

% Calculate the indexes of cells that were detected twice in the algoritm
% INPUT: 2D Matrix with cells positions in RGB image
% OUPUT: Vector with duplicate indexes

r = size(posCells,1);
tJ = 0.25; % Jaccard Threshold
% k > i because otherwise would repeate compared cells
% and would compare the same cells, which are equal for sure
% obtained by calculating J for overlaped identifications

iToRemove = []; % vector with repeated cells indexes

for i = 1:r
    for k = 1:r
        if k > i && getJaccard(posCells(i,:),posCells(k,:)) > tJ
            minSize = min(posCells(i,3),posCells(k,3));
            if minSize == posCells(i,3)
                iToRemove(end + 1) = i;
            else
                iToRemove(end + 1) = k;
            end
        end   
    end
end


end

