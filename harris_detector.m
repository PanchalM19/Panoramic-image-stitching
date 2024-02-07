clc;clear
%% Step 1 - Load Images

% Load images.
% buildingDir = fullfile('/','home','anish','Anish','Mahi','Lab 5','Main_Grafitti',{'1.jpg','2.jpg','3.jpg','4.jpg','5.jpg','6.jpg'}); %Main_Grafitti
buildingDir = fullfile('/','home','anish','Anish','Mahi','Lab 5','Cinder_block',{'1.jpg','2.jpg','3.jpg','4.jpg','5.jpg','6.jpg'}); %Cinder_block
% buildingDir = fullfile('/','home','anish','Anish','Mahi','Lab 5','Other_grafitti',{'1.jpg','2.jpg','3.jpg','4.jpg','5.jpg','6.jpg'}); %Other_grafitti
buildingScene = imageDatastore(buildingDir);

% % Display images to be stitched.
% montage(buildingScene.Files);

%% Step 2 - Register Image Pairs

% Read the first image from the image set.
I2 = readimage(buildingScene,1);
I=imrotate(I2,-90);

% Initialize features for I(1)
grayImage = im2gray(I);
% points = detectSURFFeatures(grayImage);
% [features, points] = extractFeatures(grayImage,points);

% Using Harris feature
%                     (name_of_image,max_no_of_corners_to_find,tile,size_of_tile,display_harris_corner,--------)
% [y,x,m] = harris(grayImage,500,'tile',[30 30],'disp','thresh',10000,'hsize',3,'sigma',0.5); %Main Grafitti
[y,x,m] = harris(grayImage,400,'tile',[15 15],'disp','thresh',1000,'hsize',3,'sigma',25); %Cinder block
% [y,x,m] = harris(grayImage,500,'tile',[30 30],'disp','thresh',10000,'hsize',3,'sigma',0.5); %Other grafitti
points= cat(2,x,y);
[features, points] = extractFeatures(grayImage,points);

numImages = numel(buildingScene.Files);
tforms(numImages) = projective2d(eye(3));

% Initialize variable to hold image sizes.
imageSize = zeros(numImages,2);

% Iterate over remaining image pairs
for n = 2:numImages
    
    % Store points and features for I(n-1).
    pointsPrevious = points;
    featuresPrevious = features;
        
    % Read I(n).
    I2 = readimage(buildingScene,n);
    I=imrotate(I2,-90);
    
    % Convert image to grayscale.
    grayImage = im2gray(I);    
    
    % Save image size.
    imageSize(n,:) = size(grayImage);
    
%     % Detect and extract SURF features for I(n).
%     points = detectSURFFeatures(grayImage);    
%     [features, points] = extractFeatures(grayImage, points);

%     [y,x,m] = harris(grayImage,500,'tile',[30 30],'disp','thresh',10000,'hsize',3,'sigma',0.5); %Main grafitti
    [y,x,m] = harris(grayImage,400,'tile',[15 15],'disp','thresh',10000,'hsize',3,'sigma',25); %Cinder_block
%     [y,x,m] = harris(grayImage,500,'tile',[30 30],'disp','thresh',10000,'hsize',3,'sigma',0.5); %Other grafitti
    points= cat(2,x,y);
    [features, points] = extractFeatures(grayImage,points);
  
    % Find correspondences between I(n) and I(n-1).
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
       
    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);        
    
    % Estimate the transformation between I(n) and I(n-1).
    tforms(n) = estimateGeometricTransform2D(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);
    
    % Compute T(n) * T(n-1) * ... * T(1)
    tforms(n).T = tforms(n).T * tforms(n-1).T; 
end

% Compute the output limits for each transform.
for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));
for i = 1:numel(tforms)    
    tforms(i).T = tforms(i).T * Tinv.T;
end

%% Step 3 - Initialize the Panorama

for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end

maxImageSize = max(imageSize);

% Find the minimum and maximum output limits. 
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);

%% Step 4 - Create the Panorama

blender = vision.AlphaBlender('Operation', 'Binary mask','MaskSource', 'Input port');  

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:numImages
    
    I2 = readimage(buildingScene,i);
    I=imrotate(I2,-90);
   
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    % Generate a binary mask.    
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
end

figure
imshow(panorama)



