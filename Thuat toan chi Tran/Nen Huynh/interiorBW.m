function [interior] = interiorBW(I)
% Input: grayscale image double
% Output: a binary marking the location of the interior to dissipate from

% I = imread('test3.jpg
threshold = 0.06;
I(I<=threshold) = 0;
I(I~=0) = 1;

BW = bwareaopen(I,10);

BW2 = imfill(BW,'holes');

interior = bwmorph(BW2,'open');
end

