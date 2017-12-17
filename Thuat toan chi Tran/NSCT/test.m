clc; clear all; close all;
load coeffs

subbands = coeffs{2};
n = length(subbands);

J = cell(1,n);
for i=1:n
    level = 0.2;
    K = im2bw(subbands{i}, level);
    % K = adaptivethreshold(subbands{i}, 11, 0.03, 0);
    J{i} = double(K);
end

localThreshing{1} = double(ones(size(coeffs{1})));
localThreshing{2} = J;

figure;
disp('Displaying the contourlet coefficients...') ;
showpdfb(localThreshing) ;
title('Contourlet coefficients with High-boost filtering and Thresholding level = 0.2');

%% Combine

% Parameteters:
nlevels = [3] ;        % Decomposition level
pfilter = 'pkva' ;     % Pyramidal filter
dfilter = 'pkva' ;     % Directional filter

% 
imrec = pdfbrec( localThreshing, pfilter, dfilter ) ;

% Show the reconstruction image and the original image
figure, 
imshow( imrec, [] );
title('Reconstructed image' ) ;
axis image off;