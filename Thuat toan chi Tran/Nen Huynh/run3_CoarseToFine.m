% Finding Principle Vessel by doing coarse to fine for the image after enhancement
% clc; clear all; close all;

function [PV] = run3_CoarseToFine(I)
%% Setup the parameters
DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Gaussian',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);

%% Vessel extraction database
% I = imread('test2.jpg');
% figure, imshow(I);
% if length(size(I))==3
%     I = rgb2gray(I);
% end
% I = im2double(I);

% Preprocessing
% interior = interiorBW(I);
% figure, imshow(J);
I = imadjust(I);

%% DDFB Homomorphic + Roase to Fine ( Loop )

% condition?
% N is how many time that an image runs coarse to fine
N = 2;
count = N;
while count>0
    
    count = count-1;
    J = BasicHeatInpaint(I,interior);
    %     figure,
    %     subplot(1,3,1); imshow(I,[]); title('I');
    %     subplot(1,3,2); imshow(interior,[]); title('interior');
    %     subplot(1,3,3); imshow(J,[]); title('J');
    
    enhance = DFBMultiscaleEnhance(J,DDFBoption,midOption);
    if count==N-1
        position = [83.5 2.5 429 425];
        enhance = imcrop(enhance, position);
        I2 = imcrop(J, position);
        
        % BW = Binary Image
        BW = zeros(size(enhance));
    end
    
    % Roaste to Fine using Otsu method nhieu lop
    B = RoarseToFine(enhance);
    BW = BW | B;
    figure,
    subplot(1,2,1); imshow(B); title('B');
    subplot(1,2,2); imshow(BW); title('BW');
    
    % denoise A, take the pixels that are belong to vessels
    I = I2;
    interior = 1-B;
end

% Taking the 10 largest components
% CC = bwconncomp(BW);
% numPixels = cellfun(@numel,CC.PixelIdxList);
% % [biggest,idx] = max(numPixels);
% % vt = CC.PixelIdxList{idx};
% [A,idx] = sort(numPixels,'descend');

% Removing small components
PV = bwareaopen(BW,20);

% PV = Principle vessel matrix
% PV = ones(size(BW));
% for i=1:CC.NumObjects/2
%     PV(CC.PixelIdxList{idx(i)}) = 0;
% end
% PV = 1-PV;
figure, 
subplot(1,3,1); imshow(I,[]); title('Input image');
subplot(1,3,2); imshow(BW,[]); title('BW after using Otsu Method');
subplot(1,3,3); imshow(PV,[]); title('The 10 largest components/ Principle Vessel');
end
