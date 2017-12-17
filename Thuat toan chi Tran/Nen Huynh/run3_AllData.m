% Run all database using file run3_CoarseToFine.m

clc; clear all; close all;

for ii = 130:130
    %read file
    filename = ['C:\\Users\T430s\Documents\MATLAB\Vessel Segmentation\Nen Huynh check size\Data2\a\'...
        'IM-0001-000' num2str(ii,'%03d') '.jpg'];
    I = imread(filename);
    if length(size(I))==3
        I = rgb2gray(I);
    end
    I = im2double(I);
    
    % Process
    PV = run3_CoarseToFine(I);
%     [J, t] = findNeighbors(PV,0.05,50);

    % Display
    figure, 
    subplot(1,2,1); imshow(I); title('Input');
    subplot(1,2,2); imshow(PV,[]); title('Principle Vessel');
    
    % Save file
    OutputFolder = 'C:\\Users\T430s\Documents\MATLAB\Vessel Segmentation\Nen Huynh check size\Data2\a\Result\';
    filename = strcat(num2str(ii), '.jpg'); % concentrate string
    imwrite(PV, [OutputFolder filename], 'jpg'); % the name of the image is 130.jpg and so on
    
end