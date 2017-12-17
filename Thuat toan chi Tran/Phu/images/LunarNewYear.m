figure, 
subplot(1,2,1); imshow(subI); title('subI');
subplot(1,2,2); imshow(AdapS); title('AdapS');

load subI
load AdapS

subI = im2double(subI);
AdapS = AdapS./8;

A = subI + AdapS;
figure, imshow(A,[]);

B = medfilt2(A);
figure, 
subplot(1,2,1); imshow(A,[]); title('subI+AdapS');
subplot(1,2,2); imshow(B,[]); title('Median Filter');