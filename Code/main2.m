%% Read Images
tic;

folderImages = 'images\.';
imIN = readImages(folderImages);
nImages = size(imIN,4);

%% Read Ground Truth ROI 

folderGT1 = 'GT_1\.';
imGT = readGT1(folderGT1);
nGT = size(imGT, 3);

%% Read Ground Truth Cell Positions

folderGT2 = 'GT_2\.';
posGT = readGT2(folderGT2); %cell array with all ground truth metrics
numberGT2 = size(posGT,1);

%% Find & Display Cells 

for k = 1:nImages

    [posCells{k,1}] = getCells(imIN(:,:,:,k), imGT(:,:,k));
    
    figure(k);
    subplot(2,1,1);
    displayCells(posCells{k,1}, imIN(:,:,:,k));
    title('MY');
    
    subplot(2,1,2);
    displayCells(posGT{k,1}, imIN(:,:,:,k));         
    title('GT');
    
end

%% Performance Metrics

for i = 1 : nImages
    metrics2(i,1:7) = getMetrics2(posCells{i,1}, posGT{i,1});
end

disp('    Recall   Precision  MeasureF1')

statMetrics2 = getStatMetrics2(metrics2);
disp(statMetrics2)


%% Export Data to Excel

exportExcel2(metrics2);

toc;
