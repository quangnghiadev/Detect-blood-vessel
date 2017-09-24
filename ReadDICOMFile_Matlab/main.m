info = dicominfo('40651632');
I = dicomread(info);
rgbImage = I(:,:,1:3);
implay(I);