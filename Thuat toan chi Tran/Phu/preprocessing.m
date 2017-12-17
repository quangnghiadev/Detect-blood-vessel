function output = preprocessing(filename)
ratio = 0.02;
Img = imread(filename);
if(length(size(Img))==3)
    Img = rgb2gray(Img);
end
figure,imshow(Img);
figure;
subplot(3,3,1);
imshow(Img);
[out,~,~] = FrangiFilter(Img);
theshold = 0.02;
epxilon = 0.001;
[out, radius] = Filter_Otsu(out, ratio, theshold, epxilon);
[output,~] = filter_neibor(out,ratio,2*radius);
subplot(3,3,9);
imshow(output);
figure,imshow(output);
end