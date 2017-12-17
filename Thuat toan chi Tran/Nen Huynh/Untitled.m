I = imread('vessels.jpg');
I = im2double(I);

n = size(I,1);
m = size(I,2);
J = cell(1,9);

for i=floor(n/3):floor(n/3):n
    h = 1;
    k = 1;
    for j=floor(m/3):floor(m/3):m
       K = imcrop(I,[h i; k j]);
       figure, imshow(K);
       k = i;
       h = j;
   end
end