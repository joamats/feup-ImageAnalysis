function [TP] = getTP(posCells, posGT)

% Calculate True Positives of an image, comparing it to it's Ground Truth
% INPUT: 2 Matrices with metrics of squares that limit each detected cell
% OUTPUT: Number of true positives

jaccardTH = 0.5;
TP = 0;

countedCells = length(posCells(:,1));   %number of counted cells
groundTCells = length(posGT(:,1));      %number of cells in GT

posCells = sortrows(posCells);          %sort squares by ascending value of x coordinate
posGT = sortrows(posGT);                %to improve effiency of method

for i = 1: groundTCells
    for j = 1:length(posCells(:,1))
        cellsJaccard(i,j)=getJaccard(posCells(j,:),posGT(i,:)); %save all jaccard values
    end
    [maxJaccard index]=max(cellsJaccard(i,:)); %find maximum value of jaccard index
    if(maxJaccard>jaccardTH)
        TP=TP+1;                               %increase by one the value of true positives
        posCells(index,:)=[];                  %erase detected cell
    end
    if(isempty(posCells))
        break;
    end
end

end