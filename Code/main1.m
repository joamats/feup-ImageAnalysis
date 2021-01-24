%% Read Images
tic;
folderImages = 'images\.';
imIN = readImages(folderImages);
nImages = size(imIN,4);

%% Get ROI Masks and Display
 
for k = 1:nImages
    imROI(:,:,k) = getROI(imIN(:,:,:,k));
    figure(k);
    imshow(imROI(:,:,k).*imIN(:,:,:,k), [], 'InitialMagnification','fit');
end

%% Read Ground Truth ROI 

folderGT1 = 'GT_1\.';
imGT = readGT1(folderGT1);
nGT1 = size(imGT, 3);

%% Performance Metrics

for k = 1:nImages
    metrics1(k,1:3) = getMetrics1(imGT(:,:,k), imROI(:,:,k));
end

disp('    Jaccard   Max Dif   Mean Dif')

statMetrics1 = getStatMetrics1(metrics1);
disp(statMetrics1)

%% Export Data to Excel

exportExcel1(metrics1);

toc;





