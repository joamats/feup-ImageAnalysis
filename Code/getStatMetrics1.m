function [statMetrics1] = getStatMetrics1(metrics1)
% Calculate global metrics of Task 1
% Useful for final conclusions in report
% INPUT: Matrix Number of Images x 3 with each row:
% [Jaccard Index, Maximum distance, Mean distance]
% OUTPUT: Matrix 4 x 3 with min, mean and max values of each input column

for i = 1:3
    
    statMetrics1(1,i) = min(metrics1(:,i));   % Minimums row
    statMetrics1(2,i) = mean(metrics1(:,i));  % Means row
    statMetrics1(3,i) = std(metrics1(:,i));   % Standard Deviation
    statMetrics1(4,i) = max(metrics1(:,i));   % Maximums row
    
end
end
