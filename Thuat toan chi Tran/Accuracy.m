% Accuracy
clc; clear all; close; 

addpath('Data2');

filename1 = 'C:\\Users\T430s\Documents\MATLAB\Vessel Segmentation\Final\Data2\a\Result\136.mat';
% img = imread(filename1);
% img(img>0) = 1;

load(filename1);
img = smallVessels;

filename2 = ['C:\\Users\T430s\Documents\MATLAB\Vessel Segmentation\Final\Data2\a\'...
    'Ground Truth 130-136\IM-0001-000136.tif'];
truth_img = imread(filename2);

pos = [117.5 60.5 292 345];
truth_img = imcrop(truth_img, pos);

Dice = DicePercentMeasurement( truth_img, img );
disp('Dice = ');
disp(Dice);