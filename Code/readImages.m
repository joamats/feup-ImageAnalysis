function [allImages] = readImages(folderPath)
 
% Read all the 50 images on the test dataset
% Resize all images to [1200 1600]
% INPUT: String with images' folder path
% OUTPUT: 4-D matrix with all RGB images

% Exception handling
if ~isfolder(folderPath)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', folderPath);
  uiwait(warndlg(errorMessage));
  return;
end

% Directory Pattern Construction
filePattern = fullfile(folderPath, '*.tiff');
tiffFiles = dir(filePattern);

% For each present image, get its name and read it
for k = 1:length(tiffFiles)
  baseFileName = tiffFiles(k).name;                     % Get file name
  fullFileName = fullfile(folderPath, baseFileName);    % Get file dir
  singleIm = im2double(imread(fullFileName));           % Read 1 image 
  singleIm = imresize(singleIm, [1200 1600]);           % Reduce cost
  allImages(:,:,:,k) = singleIm;                        % Add to 4-D matrix
end
end

