function [output] = getObject(Img,ratio)
S = size(Img,1)*size(Img,2);
output = Img;
[L,N] = bwlabel(Img, 8); 
BB = regionprops(L,'BoundingBox');
PP  = regionprops(L,'PixelIdxList');     %Vector containing the linear indices that represent an object
AA  = regionprops(L,'Area');             %Number of pixels in the object
for i = 1:N                             %For each region in the image do:
    P = PP(i).PixelIdxList;
    A = AA(i).Area;
    B = round(BB(i).BoundingBox);
    rangeX = [B(1):B(1)+B(3)];
    rangeY = [B(2):B(2)+B(4)];
    if(A/S*100<ratio)
        output(rangeY,rangeX) = 0;
    end
end
end