clear all; clc
I = imread('vessel.png');
if(length(size(I))==3)
    I = rgb2gray(I);
end
figure,imshow(I);
Im = im2double(I);
sigma = 20;
Img = perform_blurring(Im,sigma) - Im;
figure,imshow(Img);
c = max(Img(:));
epsilon = 1e-2;
W = epsilon + abs(Img-c);
figure,imshow(W);
% ratio = 0.02;
% theshold = 0.02;
% epxilon = 0.02;
% theta = graythresh(W);
% W1 = im2bw(W,theta);
% figure, imshow(W1);
% [Im_B, radius] = Filter_Otsu(W, 0.02, 0.02, 0.2);
% [output,~] = filter_neibor(Im_B,0.02,2*radius);
% figure, imshow(output);