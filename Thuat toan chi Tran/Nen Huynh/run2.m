% mix between Nen huynh + Truc
% 8 directional images

clc; clear all; close all;
tic
%%
DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Butterworth',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);

I = imread('vessels.jpg');
figure, imshow(I);

%% Preprocessing
if length(size(I))==3
    I = rgb2gray(I);
end
% I = im2double(I);

% interior = interiorBW(I);
% 
% I = BasicHeatInpaint(I,interior);%%???
% figure, imshow(I);

% I = imcrop(I);
figure, imshow(I);

%% DDFB
m = 3;
DirL = DDFB(I,m,52);%DirL = DDFB(I,3,52); 

% number of directional filters
n = 2^m;
for k = 1:n
    figure, imshow(DirL(:,:,k), []);
end

%% Homomorphic filter %xem lai
if exist('midOption','var') && ~isempty(midOption)
    for k = 1 : n
        DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
%         figure, imagesc(DirL(:,:,k));
%         figure, imshow(DirL(:,:,k), []);
    end
end


% m = size(DirL,3);
% K = zeros(size(DirL));
% for i=1:m
% %     figure; imshow(DirL(:,:,i), []); title(['Direction #' num2str(i)]);
%     K(:,:,i) = homoFilter2(DirL(:,:,i)); 
%     figure; imshow(K(:,:,i), []); title(['Direction #' num2str(i)]);
% end
%% Vessel Enhance
DirEnhance = DirectionalEnhance(DirL,DDFBoption);
for k = 1 : n
%     figure, imshow(DirEnhance(:,:,k), []);
    figure, imagesc(DirEnhance(:,:,k));
end

%% Combine the enhancement
% enhance = max(DirEnhance,[],3);
% chose the correct directions
A = DirEnhance;
S = [2 3 6 7];
sz = size(S,2);
count = 0;
for k=1:sz
   A(:,:,S(k)-count) = []; 
   count = count+1;
end
% enhance = mean(DirEnhance,3);
enhance = mean(A,3);

    
s1 = num2str(DDFBoption.sigma); % convert num to string
s2 = num2str(DDFBoption.beta); % convert num to string
s3 = num2str(DDFBoption.c); % convert num to string

%figure('color','white','name','Vessel Image','Numbertitle','off');
figure, imagesc(enhance,[min(min(enhance)), max(max(enhance))]);
title(['DDFBH; sigma=' s1 '; beta=' s2 '; c=' s3]);
colorbar;
axis off
toc

figure, imshow(enhance,[]);
    