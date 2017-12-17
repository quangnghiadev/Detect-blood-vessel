function [Im_B, radius] = Filter_Otsu(Img, ratio, theshold, epxilon)
I = Img;
I(I<=theshold) = 0;
I(I>theshold) = 1;
radius = 0;
Im_B = single(zeros(size(Img)));
level_a = 1; level_b = 1;
hieu_level = 1; %0.0833
% danhso = 2;
while(hieu_level>epxilon)
    level_b = level_a;
    level_a = graythresh(Img);
    hieu_level = abs(level_b - level_a);
    ImP = im2bw(Img,level_a);
    [ImP,~] = filter_neibor(ImP,ratio,0);
    ImP = imresize(ImP,size(Img));
    Im_B = Im_B + ImP;
%     subplot(3,3,danhso);
%     imshow(Im_B);
%     danhso = danhso+1;
    SK = skeleton(ImP); End_Start = []; vector = [];
    for i=1:size(SK,2)
        L = SK{i};
        End_Start = [End_Start; L(1,:); L(end,:)];
        vector1 = L(1,:) - L(min(2,end),:);
        vector2 = L(end,:) - L(max(1,end-1),:);
        vector1 = vector1/max(abs(vector1));
        vector2 = vector2/max(abs(vector2));
        vector = [vector; vector1; vector2];
    end
    hieu = 0;
    for i=1:size(End_Start,1)
        point = End_Start(i,:);
        radius1 = estimate_radius(point,vector(i,:),ImP);
        radius2 = estimate_radius(point,vector(i,:),I);
        if(radius2-radius1>hieu)
            hieu = radius2-radius1;
        end
        if(radius1>radius)
            radius = radius1;
        end
    end
    ImP = imdilate(ImP,strel('disk',ceil(hieu)));
    Img(ImP==1) = 0;
end
end


