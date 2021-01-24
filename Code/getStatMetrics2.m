function [statMetrics2] = getStatMetrics2(metrics2)
% Calculate global metrics of Task 2
% Useful for final conclusions in report
% INPUT: Matrix of metrics with columns:
% [Counted Cells, TP, FP, FN, recall, precision, F1-measure]
% OUTPUT: min, mean, max values of metrics' relevant parameters:
% recall, precision and F1-measure

for i = 5:7
    
    statMetrics2(1,i-4) = min(metrics2(:,i));   % Minimums row
    statMetrics2(2,i-4) = mean(metrics2(:,i));  % Means row
    statMetrics2(3,i-4) = std(metrics2(:,i));   % Standard Deviation
    statMetrics2(4,i-4) = max(metrics2(:,i));   % Maximums row
    
end
end