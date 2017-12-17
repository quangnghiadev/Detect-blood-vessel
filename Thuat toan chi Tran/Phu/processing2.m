function processing2(link)
tic;
ratio = 0.02;
filename = link;
Img = imread(filename);
if(length(size(Img))==3)
    Img = rgb2gray(Img);
end
S = detect_vessel2(Img,ratio);
toc
end