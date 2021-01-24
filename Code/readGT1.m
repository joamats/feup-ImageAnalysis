function [allImages] = readGT1(folderPath)
 
% Read all the 50 GT images on the test dataset
% and resize them to [1200 1600], matching image dataset
% INPUT: String with images' folder path
% OUTPUT: 3-D matrix with all Binary images

% Exception handling
if ~isfolder(folderPath)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', folderPath);
  uiwait(warndlg(errorMessage));
  return;
end

% Directory Pattern Construction
filePattern = fullfile(folderPath, '*.png');
tiffFiles = dir(filePattern);

% For each present image, get its name and read it
for k = 1:length(tiffFiles)
  baseFileName = tiffFiles(k).name;                     % Get file name
  fullFileName = fullfile(folderPath, baseFileName);    % Get file dir
  singleIm = logical(imread(fullFileName));             % Read 1 image, boolean 
  singleIm = imresize(singleIm, [1200 1600]);           % Resize to Match Train Images
  allImages(:,:,k) = singleIm;                          % Add to 3-D matrix

end
end