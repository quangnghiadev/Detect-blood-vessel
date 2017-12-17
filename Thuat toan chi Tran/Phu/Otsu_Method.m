function Img_B = Otsu_Method(Img, num)
Img_B = single(zeros(size(Img)));

sluong = size(Img,1)*size(Img,2);
level = 1;
while(level>0.2)
    level = graythresh(Img)
    Img_Pro = im2bw(Img,level);
    Img_B = Img_B + Img_Pro;
    ImP = imdilate(Img_Pro,strel('disk',num));
    Img(ImP==1) = 0;
end

end