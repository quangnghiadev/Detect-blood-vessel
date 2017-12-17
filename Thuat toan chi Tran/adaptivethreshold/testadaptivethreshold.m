% clear;close all;
% im1=imread('page.png');
% im2=imread('tshape.png');
% bwim1=adaptivethreshold(im1,11,0.03,0);
% bwim2=adaptivethreshold(im2,15,0.02,0);
% subplot(2,2,1);
% imshow(im1);
% subplot(2,2,2);
% imshow(bwim1);
% subplot(2,2,3);
% imshow(im2);
% subplot(2,2,4);
% imshow(bwim2);

clear; close all; clc;
I = imread('vessels.jpg');
I = rgb2gray(I);
I = im2double(I);
J = adaptivethreshold(I, 11, 0.03, 0);
figure, 
subplot(1,2,1); imshow(I); title('vessels.jpg');
subplot(1,2,2); imshow(1-J); title('Adapative Threshold');

% find the largest component
CC = bwconncomp(1-J);
numPixels = cellfun(@numel,CC.PixelIdxList);
n = 50;
[S, idx] = sort(numPixels, 'descend');
PV = zeros(size(I));
for i=1:n
    PV(CC.PixelIdxList{idx(i)}) = 1;
end
figure, 
subplot(1,2,1); imshow(I); title('Input');
subplot(1,2,2); imshow(PV,[]); title('Adaptive Threshold');

% Binarize Image Using Locally Adaptive Thresholding
% I = imread('vessels.jpg');
% I = rgb2gray(I);
% I = im2double(I);
% BW = imbinarize(I, 'adaptive');
% figure
% imshowpair(I,BW,'montage')