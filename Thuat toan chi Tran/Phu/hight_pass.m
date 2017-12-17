function W = hight_pass(I)
Im = im2double(I);
sigma = 20;
Img = perform_blurring(Im,sigma) - Im;
% figure,imshow(Img);
c = max(Img(:));
epsilon = 1e-2;
W = epsilon + abs(Img-c);
W = im2uint8(W);
end