function [output, kc_euclid] = findNeighbors(Img,ratio,ep_kc)
n = size(Img,1); m = size(Img,2);
S = n*m; kc_euclid = 0;
output = Img;
[L,N] = bwlabel(Img, 8); 
PP  = regionprops(L,'PixelIdxList');
AA  = regionprops(L,'Area'); 
id = 0;
max_area = 0;
DS = [];
Toado = cell(1);
for i=1:N
    A = AA(i).Area;
    P = PP(i).PixelIdxList;
    XY = getxy(n,P);
    Toado{i} = XY;
    if(A/S*100<ratio)
        output(L==i) = 0;
        continue;
    end
    DS = [DS i];
    if(A>max_area)
        id = i;
        max_area = A;
    end
end
if(id==0)
    return;
end
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
            if(euclid>kc_euclid)
                kc_euclid = euclid;
            end
        end
    end
    i = i+1;
    if(i>length(DS))
        i = 1;
        luot = luot+1;
    end
end
for i=1:length(DS)
    if(isempty(find(List==DS(i))))
        output(L==DS(i)) = 0;
    end
end

end









