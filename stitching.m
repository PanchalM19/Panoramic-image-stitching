clc;clear;
% % 
%%Step 1 - Load Images
% Load images.

buildingDir=fullfile('/','home','anish','myRobo','MatFiles','Codes','Lab-5','Images','1',{'1.jpg';'2.jpg';'3.jpg';'4.jpg';'6.jpg'}); %     FIRST: MAIN GRAFFITI
% buildingDir=fullfile('/','home','anish','myRobo','MatFiles','Codes','Lab-5','Images','cinder',{'JPEGimage.jpg';'JPEGimage2.jpg';'JPEGimage3.jpg';'JPEGimage4.jpg';'JPEGimage5.jpg';'JPEGimage6.jpg'});       %     SECOND: CINDER BLOCK
% buildingDir=fullfile('/','home','anish','myRobo','MatFiles','Codes','Lab-5','Images','graffiti_big',{'1.jpg';'2.jpg';'3.jpg';'4.jpg';'5.jpg';'6.jpg'});     %       THIRD: SECOND GRAFFITI

buildingScene = imageDatastore(buildingDir);
% Display images to be stitched.
montage(buildingScene.Files)                      %SHOW ORIGINAL SET OF IMAGES
%% 

% Params for harris_edit:
%  N               500    maximum number of interest points to return
%  'disp'          N/A    overlays corner points on image
%  'subpixel'      N/A    analytically calculate subpixel precision of corner locations by fitting a quadratic surface to corner response function                      
%  'thresh'          0    smallest acceptable value of response function
%  'hsize_i          3    size of the smoothing Gaussian mask           % IM GUESSING BLUR SIZE
%  'sigma_i         0.5   standard deviation of Gaussian filter           % IM GUESSING SENSITIVITY
%  'tile'          [1 1]  break the image into regions [y x] to distribute feature points more uniformly
%  'mask'           M     array of 1's same size as image defining where to compute feature points (useful for radially compensated images)
%  'eig'           N/A    use smallest eigenvalue as response function, o.w. use response function (default) originally proposed by Harris
%  'fft'           N/A    perform smoothing filtering in freqeuncey domain, o.w. perform in spatial domain (default)
% Step 2 - Register Image Pairs
% Read the first image from the image set.
% I = readimage(buildingScene,1);
I2 = readimage(buildingScene,1);
I=imrotate(I2,-90);
% Initialize features for I(1)
grayImage = im2gray(I);

% points = detectSURFFeatures(grayImage);                         %ORIGINAL
% [features, points] = extractFeatures(grayImage,points);       %ORIGINAL

% MY PARAM SETS:
% numberOfPoints= 500;       % THIS IS FOR PLAYING
% myTileX=15;
% myTileY=15;
% myThresh=10000;
% myHSizeBlur=3;
% mySigmaSensitivity=0.5;

% numberOfPoints= 500;       % THIS IS FOR MAIN GRAFITTI
% myTileX=60;
% myTileY=60;
% myThresh=200;
% myHSizeBlur=80;
% mySigmaSensitivity=4;

% numberOfPoints= 1000;       % THIS IS FOR CINDER BLOCK
% myTileX=15;
% myTileY=15;
% myThresh=10000;
% myHSizeBlur=3;
% mySigmaSensitivity=0.5;

numberOfPoints= 600;%                              % THIS IS FOR SECOND 15% OVERLAP GRAFITTI
myTileX=30;                 %
myTileY=30;                 %
myThresh=100000;          %
myHSizeBlur=25;         %
mySigmaSensitivity=5; %

%  [y,x,m] = harris_edit(grayImage,1000,'tile',[10 10],'disp');
%  [y,x,m] = harris_edit(grayImage,500,'tile',[30 30],'disp');
%  [y,x,m] = harris_edit(grayImage,500,'tile',[30 30],'disp','thresh',10000,'hsize',3,'sigma',0.5);
%  [y,x,m] = harris_edit(grayImage,500,'tile',[30 30],'disp','thresh',1000,'hsize',5,'sigma',0.5,'eig');
%  [y,x,m] = harris_edit(grayImage,1500,'tile',[20 20],'disp','thresh',1000,'hsize',5,'sigma',10,'eig','fft');
% [y,x,m] = harris_edit(grayImage,numberOfPoints,'tile',[myTileX myTileY],'disp','thresh',myThresh,'hsize',myHSizeBlur,'sigma',mySigmaSensitivity,'eig','fft');      % FIXED LINE WITHOUT DISP... LOL
% [y,x,m] = harris_edit(grayImage,numberOfPoints,'tile',[myTileX myTileY],'disp','thresh',myThresh,'hsize',myHSizeBlur,'sigma',mySigmaSensitivity,'eig','fft');      % FIXED LINE
[y,x,m] = harris_edit(grayImage,numberOfPoints,'tile',[myTileX myTileY],'disp','thresh',myThresh,'hsize',myHSizeBlur,'sigma',mySigmaSensitivity);      % FIXED LINE W/O SOME PARAMS
% ~~~~~~~~~~~~~~~~~TRYING FOR ONE ~~~~~~~~~~~~~~~~~~~
%% CONTINUE: Step 2
points= cat(2,x,y);
[features, points] = extractFeatures(grayImage,points);

% Initialize all the transforms to the identity matrix. Note that the
% projective transform is used here because the building images are fairly
% close to the camera. Had the scene been captured from a further distance,
% an affine transform would suffice.
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
    % I = readimage(buildingScene, n);
    I2 = readimage(buildingScene,n);
    I=imrotate(I2,-90);
    
    % Convert image to grayscale.
    grayImage = im2gray(I);    
    
    % Save image size.
    imageSize(n,:) = size(grayImage);
    
    % Detect and extract SURF features for I(n).

%     points = detectSURFFeatures(grayImage);                         %ORIGINAL
%     [features, points] = extractFeatures(grayImage, points);    %ORIGINAL

% [y,x,m] = harris_edit(grayImage,3000,'tile',[15 15],'disp','thresh',100,'hsize',25,'sigma',5,'eig','fft');      % FINAL FOR MAIN GRAFFITI
% [y,x,m] = harris_edit(grayImage,numberOfPoints,'tile',[myTileX myTileY],'thresh',myThresh,'hsize',myHSizeBlur,'sigma',mySigmaSensitivity,'eig','fft');      % FIXED LINE
[y,x,m] = harris_edit(grayImage,numberOfPoints,'tile',[myTileX myTileY],'thresh',myThresh,'hsize',myHSizeBlur,'sigma',mySigmaSensitivity);      % FIXED LINE W/O SOME PARAMS
    points= cat(2,x,y);
    [features, points] = extractFeatures(grayImage, points);
  
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

%% Compute the output limits for each transform.
for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end
%% Compute the average X limits for each transforms and find the image that is in the center

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);
%% Apply the center image's inverse transform to all the others

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

blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:numImages
    
%     I = readimage(buildingScene, i);
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