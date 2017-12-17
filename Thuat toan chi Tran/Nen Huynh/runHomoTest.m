% Homomorphic Filter with Gaussian + Butterworth method
% If comparing with the method in http://blogs.mathworks.com/steve/2013/06/25/homomorphic-filtering-part-1/
% 
clc; clear all; close all;

I = im2double(imread('AT3_1m4_01.tif'));
% figure, imshow(I,[]);

% The distance from the center
[X,Y] = ndgrid(1-size(I,1)/2:size(I,1)/2,1-size(I,2)/2:size(I,2)/2);
abs_omega = sqrt(X.^2+Y.^2);

if ~exist('option','var') || isempty(option)
    option = struct('method','Butterworth','n',2,...
        'D0',80,'alphaL',0.5,'alphaH',2);
end

% Construct the high?pass filter
if strcmp(option.method,'Ideal')
    H = double(abs_omega > option.D0);
elseif strcmp(option.method,'Butterworth')
    H = 1./(1+(option.D0 ./ abs_omega).^(2 * option.n));
elseif strcmp(option.method,'Gaussian')
    H = 1 - exp(-abs_omega.^2 / (2 * option.D0^2));
else
    error(['Unknown method: ' option.method]);
end

% The homomorphic filter function
H = (option.alphaH-option.alphaL).*H + option.alphaL;

% Apply the homomorphic filter process
freqI = fftshift(fft2(log2(1+I)));
homoI = exp(abs(ifft2(ifftshift(H.* freqI))));

% figure, imshow(homoI,[]);
% figure, imagesc(homoI, [min(min(I)) max(max(I))]);
imshowpair(I, homoI, 'montage')