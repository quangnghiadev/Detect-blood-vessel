% run.m
% function[enhance] = run(I)

clc; clear all; close all;

%% A. Setup the parameters

MVEoption = struct('FrangiScaleRange',[1 6],'FrangiScaleRatio',2,...
    'FrangiBetaOne',0.75,'FrangiBetaTwo',15,...
    'BlackWhite',true,'verbose',false);

DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Gaussian',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);


%% Vessel extraction database

%DATA = cell(1)

% I = imread('vessels.jpg');
% I = double(rgb2gray(I));
% figure, imshow(I);
I = imread('test2.jpg');
% % DirL = DDFB(I,4,52);
% figure, imshow(I);
if length(size(I))==3
    I1 = rgb2gray(I);
end
I1 = im2double(I);

% Preprocessing
interior = interiorBW(I1);

I1 = BasicHeatInpaint(I1,interior);%%???
figure, imshow(I1);

% I = imcrop(I1,[110.5 55.5 293 363]); %test2,);%[96.5 68.5 325 332] test3
% subplot(1,2,1);
% imshow(I1,[]);
% subplot(1,2,2);
% imshow(I,[]);

%DATA{1} = struct('I',I);

% t = find(I1==0);
% t1=find(I1>0);
% value=mean(I1(t1));
% I1(t)=value;
% figure, imshow(I1);

%% DDFB
% Temp = struct();
%
% Temp.DDFBoption = DDFBoption;
%
% enhance = DFBMultiscaleEnhance(I,Temp.DDFBoption);
%
% Temp.enhance = enhance;
% figure, imagesc(Temp.enhance);
% title('DDFB; sigma=2,3,4,5,6; beta=1; gama=15');
% colorbar;
% axis off

%% DDFB Homomorphic mid
% for i=10:80
%     
%     DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
%         'beta', 1,'gamma', i,...
%         'DarkonLight',false);
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    Temp.midOption = midOption;
    
    enhance = DFBMultiscaleEnhance(I1,Temp.DDFBoption,Temp.midOption);
    
    Temp.enhance = enhance;
    
    s1 = num2str(DDFBoption.sigma); % convert num to string
    s2 = num2str(DDFBoption.beta); % convert num to string
    s3 = num2str(DDFBoption.c); % convert num to string
    
    %figure('color','white','name','Vessel Image','Numbertitle','off');
    figure, imagesc(Temp.enhance,[min(min(Temp.enhance)), max(max(Temp.enhance))]);
%     title(['DDFBH; sigma=' s1 '; beta=' s2 '; c =' s3]);
%     colorbar;
    axis off

    %save file
    
%     OutputFolder = 'C:\\Users\T430s\Documents\MATLAB\Phan doan tim mach\Nen Huynh\Result\im_';
%     filename = strcat(s1, '_', s2, '_', s3, '.jpg'); % concentrate string
%     
%     imwrite(Temp.enhance, [OutputFolder filename], 'jpg');
% end

% min1 = min(min(Temp.enhance));
% max1 = max(max(Temp.enhance));
% Y = uint8((Temp.enhance-min1).*255/(max1-min1));
% figure, imshow(Y);