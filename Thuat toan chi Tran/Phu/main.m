clc; clear all; close all; tic;
ratio = 0.02;

%% InPut1: DICOMFILE
% dicomfile = 'dcm/00000317'; %'dcm/00000318'; 
% frame=30;  % 34
% data=dicomread(dicomfile);
% data=data(:,:,:);
% Img = data(:,:,frame);
% detect_vessel(Img,theshold,ratio,ep_kc);

%% Input2: PNG or JPG FILE
filename = 'vessels.jpg';
Img = imread(filename);
% Img = imcrop(Img);
figure, imshow(Img);
if(length(size(Img))==3)
    Img = rgb2gray(Img);
end
% Img = imcrop(Img);
S = detectVessel(Img,ratio);
toc





