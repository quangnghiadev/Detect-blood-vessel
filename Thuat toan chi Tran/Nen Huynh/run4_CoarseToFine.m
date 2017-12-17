% Do coarse to fine for directional images
clc; clear all; close all;

%% A. Setup the parameters
DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Gaussian',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);

if ~isfield(DDFBoption,'N')
    DDFBoption.N = 3;
end

if ~isfield(DDFBoption,'sigma')
    DDFBoption.sigma = 2 : 1 : 6;
end

if ~isfield(DDFBoption,'beta')
    DDFBoption.beta = 0.75;
end

if ~isfield(DDFBoption,'c')
    DDFBoption.c = 15;
end

if ~isfield(DDFBoption,'LightonDark')
    DDFBoption.LightonDark = false;
end

%% Vessel extraction database
I = imread('test2.jpg');
figure, imshow(I);
if length(size(I))==3
    I = rgb2gray(I);
end
I = im2double(I);

%% Preprocessing
interior = interiorBW(I);

I = BasicHeatInpaint(I,interior);%%???
% figure, imshow(J);

%% DDFB Homomorphic

Temp = struct();

Temp.DDFBoption = DDFBoption;

Temp.midOption = midOption;

Filter = CreateDirectionalFilters(DDFBoption.N);

position = [83.5 2.5 429 425];
I = imcrop(I, position);

DirL = zeros(size(I,1),size(I,2),16);%16 is the number of directional images
for k = 1 : 16
    DirL(:,:,k) = convolve2(I,Filter(:,:,k),'same',0.01);
end

%% mid?step filter
if exist('midOption','var') && ~isempty(midOption)
    for k = 1 : 16
        DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
    end
end

%% Vessel Enhance
DirEnhance = DirectionalEnhance(DirL,DDFBoption);

RTF = zeros(size(I,1),size(I,2),16);
for k = 1 : 16
    RTF(:,:,k) = RoarseToFine(DirEnhance(:,:,k));
end

Output = mean(RTF,3);

figure,
subplot(1,2,1); imshow(I); title('I');
subplot(1,2,2); imshow(Output); title('Output');

% denoise A, take the pixels that are belong to vessels
