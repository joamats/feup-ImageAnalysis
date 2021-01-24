function [metrics2] = getMetrics2(posCells, posGT)

% Calculate metrics for Task 2
% INPUT: 2-D matrices with Image and Ground Truth Positions
% OUTPUT: Counted Cells, True Positives (TP), False Positives (FP), False Negatives (FN),
% recall, precision and F1-measure in a row vector

beta = 1; %F1-measure

countedCells = length(posCells(:,1));   %number of counted cells
groundTCells = length(posGT(:,1));      %number of cells in GT

TP = getTP(posCells,posGT);             %number of true positives
FP = countedCells-TP;                   %number of false positives
FN = groundTCells-TP;                   %number of false negatives

recall = TP/(TP+FN);                    %recall
precision = TP/(TP+FP);                 %precision
measureF = (pow2(beta)+1)*recall*precision/(pow2(beta)*precision+recall); %F-measure

metrics2 = [countedCells, TP, FP, FN, recall, precision, measureF];  % Concatenate for output

end

