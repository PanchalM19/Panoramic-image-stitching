clc;clear;
II = imread('1.jpg');
I = imrotate(II,-90);
image(I);
[y,x,m] = harris_edit(I,1000,'tile',[100 100],'disp');

%  N               500    maximum number of interest points to return
%  'disp'          N/A    overlays corner points on image
%  'subpixel'      N/A    analytically calculate subpixel precision of corner locations by fitting a quadratic surface to corner response function                      
%  'thresh'          0    smallest acceptable value of response function
%  'hsize_i          3    size of the smoothing Gaussian mask
%  'sigma_i         0.5   standard deviation of Gaussian filter
%  'tile'          [1 1]  break the image into regions [y x] to distribute feature points more uniformly
%  'mask'           M     array of 1's same size as image defining where to compute feature points (useful for radially compensated images)
%  'eig'           N/A    use smallest eigenvalue as response function, o.w. use response function (default) originally proposed by Harris
%  'fft'           N/A    perform smoothing filtering in freqeuncey domain, o.w. perform in spatial domain (default)