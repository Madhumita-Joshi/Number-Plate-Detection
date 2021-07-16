close all;
clear all;
 
%PREPROCESSING
 
% Inputting original vehicular image
im = imread('img/car.jpg');
im = imresize(im, [480 NaN]);
figure();
imshow(im);
title("Original")
 
% Converting RGB image to Grayscale image
imgray = rgb2gray(im);
figure();
imshow(imgray);
title("Gray Scale")
 
% Converting gray scale image to binary image and then apllying sobel
% operator
imbin = imbinarize(imgray);
im = edge(imgray, 'sobel');
figure();
imshow(im);
title("Binarized + Sobel Operator")
 
% ISOLATING REGION OF INTEREST
%Dilation
im = imdilate(im, strel('diamond', 2));
figure();
imshow(im);
title("Dialated")
 
%Hole filling
im = imfill(im, 'holes');
figure();
imshow(im);
title("Hole Filling")
 
%Erosion
im = imerode(im, strel('diamond', 10));
figure();
imshow(im);
title("Eroded")
 
 
% ISOLATING INDIVIDUAL CHARACTERS
 
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    
 
%all above step are to find location of number plate
 
im = imcrop(imbin, boundingBox);
 
%resize number plate to 240 NaN
im = imresize(im, [240 NaN]);
 
%clear dust
im = imopen(im, strel('rectangle', [4 4]));
 
%remove some object if it width is too long or too small than 500
im = bwareaopen(~im, 500);
%%%get width
 [h, w] = size(im);
 
imshow(im);
 
 
%read letter
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);
 
noPlate=[]; % Initializing the variable of number plate string.
 
for i=1:count
   ow = length(Iprops(i).Image(1,:))
   oh = length(Iprops(i).Image(:,1))
  
   if ow<(h/2) && oh>(h/3)
       letter=readLetter(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       figure; imshow(Iprops(i).Image);
       noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
       display(noPlate)
   end
end
