clc; clear all; close all;

addpath('NSCT');
addpath('adaptivethreshold');
addpath('Images');
addpath('Functions');


load croppedI

% use Contourlet Transform in here

% im = imread('test2.jpg');
% im = imcrop(im);
% im = imcrop(im, [113.5 62.5 302 337]); % test2.jpg

im = im2double(croppedI);
figure, imshow(im, []);

% Preprocessing
im2 = imadjust(im);

nlevels = 3 ;        % Decomposition level
%pfilter = 'pkva' ;              % Pyramidal filter
dfilter = 'dmaxflat7'; %'cd' ;              % Directional filter

% Nonsubsampled Contourlet decomposition
coeffs = nsdfbdec( im2, dfilter, nlevels );


%% Thresholding
% Otsu method
% t = coeffs{1};
% level = graythresh(t);
% J = im2bw(t, level);
% figure, imshow(J); title('NSDFB + Otsu Method');

% Removing illumination
option = struct('method','Butterworth','D0',1,'n',2,'alphaL',.0999,'alphaH',1.01);

% Adaptive Threshold for each subbands
for i=1:length(coeffs)
    % figure, imshow(coeffs{i});
    homoC = homofilter(coeffs{i}, option);
    figure, imshow(homoC, []);
    % k = adaptivethreshold(homoC, 20, 0.03, 0);
    %figure, imshow(k, []); title('NSDFB + Adaptive Threshold');
    corec{i} = homoC;
end

% Nonsubsampled Contourlet transform (NSSC) reconstruction
imrec = nsdfbrec( corec, dfilter);
figure, imshow(imrec, []);

% Adaptive Threshold for Input Image
AdapI = adaptivethreshold(im, 20, 0.03, 0);

figure,
subplot(1,2,1); imshow(im,[]); title('Input Image');
subplot(1,2,2); imshow(AdapS,[]); title('NSDFB + Adaptive Threshold');
% subplot(1,3,3); imshow(AdapI,[]);title('Adaptive threshold ONLY');

figure, imshow(AdapI,[]);title('Adaptive threshold ONLY');

% % Finding the pixels that have value 0->4=0 
% 
% AdapS2 = AdapS;
% level = 5;
% AdapS2(find(AdapS2 <= level)) = 0;
% AdapS2(find(AdapS2 > level)) = 1;
% figure, imshow(AdapS2,[]); title('BW');
% 
% % Take the largest components
% % Transfer AdapS to BW
% BW = 1-AdapS2;
% PV = zeros(size(AdapS2));
% CC = bwconncomp(BW);
% numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idx] = max(numPixels);
% PV(CC.PixelIdxList{idx}) = 1;
% figure, imshow(PV);

% Taking each level of AdapS
% n = max(max(AdapS));
% EachLevel = cell(1,n-1);
% temp = zeros(size(AdapS));
% for i=1:n-1
%     temp(find(AdapS==i)) = 1;
%     EachLevel{i} = temp;
%     figure, imshow(temp);
% end

% AdapS -> BW



