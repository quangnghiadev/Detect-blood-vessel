close all
imshow(I,[])
I3=otsu(I,3);
I2=otsu(I,2);
subplot(1,2,1)
imshow(I3,[]);
subplot(1,2,2)
imshow(I2,[]);

imshow(enhance,[]);
A1=enhance*255/max(max(enhance));
imshow(A1,[]);

A2=otsu(A1,2);
imshow(A2,[]);

subplot(1,2,1)
imshow(A1,[]);
subplot(1,2,2)
imshow(A2,[]);

imshow(enhance,[]);
A1=enhance*255/max(max(enhance));

cmap = colormap;
res = grs2rgb(A1,cmap);

Img=otsu(res,2);
imshow(Img,[]);

Img1=otsu(res,3);

Img2=otsu(res,4);


subplot(1,4,1)
imshow(res,[]);
subplot(1,4,2)
imshow(Img,[]);
subplot(1,4,3)
imshow(Img1,[]);
subplot(1,4,4)
imshow(Img2,[]);

subplot(1,2,1);
imshow(I,[]);
subplot(1,2,2)
imshow(Img2,[]);

