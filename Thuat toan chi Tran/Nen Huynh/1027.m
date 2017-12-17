% Taking the 10 largest components
CC = bwconncomp(BW);
numPixels = cellfun(@numel,CC.PixelIdxList);
[A,idx] = sort(numPixels,'descend');
PV = ones(size(BW));
for i=1:CC.NumObjects/2
    PV(CC.PixelIdxList{idx(i)}) = 0;
end
figure, imshow(1-PV,[]);
figure, 
subplot(1,3,1); imshow(I,[]); title('Input image');
subplot(1,3,2); imshow(BW,[]); title('BW');
subplot(1,3,3); imshow(1-PV,[]); title('the 10 largest components');