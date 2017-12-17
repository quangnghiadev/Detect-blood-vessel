function [interior] = interiorBW(I)
% Input: grayscale image
% Output: a binary marking the location of the interior to dissipate from

% I = imread('test3.jpg');

R = bwmorph(I,'remove');
%figure, imshow(R)

S = bwmorph(R,'close');
%figure, imshow(S)

T = S;
T(1,:)=1;
T(size(I,2),:)=1;
T(:,1)=1;
T(:,size(I,2))=1;

T(1,size(I,2)/2)=0;

W = imfill(T,'holes');

W(1,size(I,2)/2)=1;

interior = logical(1-W);
% figure, imshow(interior);

% CC = bwconncomp(1-R);
% 
% numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idx] = max(numPixels);
% BW(CC.PixelIdxList{idx}) = 0;
end

