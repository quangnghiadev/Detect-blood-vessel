function [PV] = takingPV(I)

% clc, clear all; close all;
% % load I
% load croppedI
% % xoa mach chinh?
% % Remove PV in cropped I? NoOOOOOOOO
% med = mean(mean(croppedI));
% croppedI(find(croppedPV==1)) = med;
% I = croppedI;

% This function uses Nen Huynh method to take the principle vessel
%% Setup the parameters
DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Gaussian',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);

% Preprocessing
% interior = interiorBW(I);
% figure, imshow(J);
% I = imadjust(I);
figure, imshow(I); title('croppedI');

%% DDFB Homomorphic + Roase to Fine ( Loop )

% condition?
% N is how many time that an image runs coarse to fine
N = 2;
BW = zeros(size(I));
J = I;

while N>0
    
    N = N-1;
    
    enhance = DFBMultiscaleEnhance(J,DDFBoption,midOption);
    
    % Roaste to Fine using Otsu method nhieu lop
    B = RoarseToFine(enhance); 
    
    BW = BW | B;
%     figure,
%     subplot(1,2,1); imshow(B); title('B');
%     subplot(1,2,2); imshow(BW); title('BW');
    
    % denoise A, take the pixels that are belong to vessels
    J = I;
    interior = 1-B;
    
    J = BasicHeatInpaint(J,interior);
    
end

% Removing small components
% PV = bwareaopen(BW,20);
PV = BW;

figure, 
subplot(1,2,1); imshow(I,[]); title('Input image');
subplot(1,2,2); imshow(BW,[]); title('BW after using roarse to fine');
% subplot(1,3,3); imshow(PV,[]); title('The 20 largest components/ Principle Vessel');
end
