function output = increa_diamet(Img, ep_kc)
output = Img; n = size(Img,1);
[L,N] = bwlabel(Img, 8);
PP  = regionprops(L,'PixelIdxList');
AA  = regionprops(L,'Area'); 
id = 0;
max_area = 0;
DS = 1:N;
Toado = cell(1);
for i=1:N
    A = AA(i).Area;
    P = PP(i).PixelIdxList;
    XY = getxy(n,P);
    Toado{i} = XY;
    if(A>max_area)
        id = i;
        max_area = A;
    end
end
if(id==0)
    return;
end
output(L~=id) = 0;
List = id;
List_Toado = Toado{id};
luot = 1; i = 1;
euclid = 0;
soluot = ceil(sqrt(length(DS)));
while(i<=length(DS)&&luot<=soluot)
    if(isempty(find(List==DS(i))))
        H = Toado{DS(i)};
        euclid = khoangcach(H,List_Toado);
        if(euclid<=ep_kc)
            List = [List DS(i)];
            List_Toado = [List_Toado; H];
            Im = Img;
            Im(L~=DS(i)) = 0;
            Im = imdilate(Im,strel('disk',ceil(euclid+1)));
            output = output + Im;
        end
    end
    i = i+1;
    if(i>length(DS))
        i = 1;
        luot = luot+1;
    end
end
end