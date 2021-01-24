function [allPos] = readGT2(folderPath)

% Read all the 50 GT files with cells' location on the dataset
% INPUT: String with files' folder path
% OUTPUT: 2-D cell array will all GT metrics

% Exception handling
if ~isfolder(folderPath)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', folderPath);
  uiwait(warndlg(errorMessage));
  return;
end

% Directory Pattern Construction
filePattern = fullfile(folderPath, '*.mat');
tiffFiles = dir(filePattern);

% For each present file, get its name and read it
for k = 1:length(tiffFiles)
  baseFileName = tiffFiles(k).name;                         % Get file name
  fullFileName = fullfile(folderPath, baseFileName);        % Get file dir
  singleFile = cell2mat(struct2cell(load(fullFileName)));   % Read 1 file
  allPos{k,1} = singleFile;                                 % Add to 2-D cell array
end

end