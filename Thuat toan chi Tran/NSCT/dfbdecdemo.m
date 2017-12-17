%this one

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image decomposition by nonsubsampled contourlet transform (NSSC).
% This is the iterated filter bank that computes the nonsubsampled
% contourlet transform.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all; close all;
% addpath('Images');
% addpath('Functions');

% Input image
% I = imread ('test2.jpg') ;
% % im = rgb2gray(im);
% im = imcrop(I);
% save im im 
load im

% Preprocessing
% High-boost filtering
% Wap = zeros(3); Wap(2,2) = 1;
% % Whp = [0 -1 0; -1 4 -1; 0 -1 0];
% Whp = -ones(3); Whp(2,2) = 8;
% c = 2;
% Whb = Wap + c*Whp;
% t = imfilter(im, Whb);

% Show the input image
disp( 'Displaying the input image...');
clf;
imagesc(im, [0, 255]);
title( 'Input image' ) ;
axis image off;
colormap(gray);

% Parameteters:
nlevels = 3 ;        % Decomposition level
%pfilter = 'pkva' ;              % Pyramidal filter
dfilter = 'dmaxflat7'; %'cd' ;              % Directional filter

% Nonsubsampled Contourlet decomposition
coeffs = nsdfbdec( double(im), dfilter, nlevels );
disp( nlevels); disp(dfilter);

% Display the coefficients
disp('Displaying the contourlet coefficients...') ;
% shownsct( coeffs ) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nonsubsampled Contourlet transform (NSSC) reconstruction.
% This is the inverse of nsscdec, i.e.
% imrec = nsscrec(coeffs, dfilter, pfilter);
% would reconstruct imrec = im
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% do something with coeffs
% for i=1:length(coeffs)
%     RTF{i} = RoarseToFine(coeffs{i});
% end

term = coeffs{1};
figure, imshow(term,[]);
% Thresholding
% Otsu method
level = graythresh(term);
J = im2bw(term, level);
figure, imshow(J,[]);

% Adaptive Threshold
K = zeros(size(im));
for i=1:length(coeffs)
    k = adaptivethreshold(coeffs{i}, 11, 0.03, 0);
    K = K+k;
end
figure, imshow(K,[]); 
title('Nonsubsample directional filter bank decomposition + Adaptive Threshold');

% Reconstruct image
imrec = nsdfbrec(coeffs, dfilter ) ;

% Show the reconstruction image and the original image

figure;
subplot(1,2,1), imagesc( im, [0, 255] ); 
title('Original image' ) ;
colormap(gray);
axis image off;
subplot(1,2,2), imagesc( imrec, [0, 255] );
title('Reconstructed image' ) ;
colormap(gray);
axis image off;


mse = sum( sum( (imrec - double(im)).^2 ) );
mse = mse / prod(size(im));

disp( sprintf('The mean square error is: %f', mse ) );
disp(' ');