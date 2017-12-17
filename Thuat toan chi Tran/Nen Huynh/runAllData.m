clc; clear all; close all;

for ii = 130:130
    %read file
   filename = ['C:\\Users\T430s\Documents\MATLAB\Phan doan tim mach\Nen Huynh\Data2\a\'...
       'IM-0001-000' num2str(ii,'%03d') '.jpg'];
   I = imread(filename);
   figure, imshow(I);
   
   %process
   J = run(I);
   
   %save file  
   OutputFolder = 'C:\\Users\T430s\Documents\MATLAB\Phan doan tim mach\Nen Huynh\Data2\a\Result\';
   filename = strcat(num2str(ii), '.jpg'); % concentrate string
   imwrite(I, [OutputFolder filename], 'jpg'); % the name of the image is 130.jpg and so on
   
end