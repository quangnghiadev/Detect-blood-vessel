function output = increa_diameter(Img, ep_kc)
output = single(zeros(size(Img))); n = size(Img,1);
[L,N] = bwlabel(Img, 8);
PP  = regionprops(L,'PixelIdxList'); 
for i=1:N
    Pi = PP(i).PixelIdxList;
    XYi = getxy(n,Pi);
    Im = Img; Im(L~=i) = 0;
    kc_euclid = ep_kc;
    for j=1:N
        if(j~=i)
            Pj = PP(j).PixelIdxList;
            XYj = getxy(n,Pj);
            euclid = khoangcach(XYi,XYj);
            if(euclid<=ep_kc&&euclid<kc_euclid)
                kc_euclid = euclid;
            end
        end
    end
    Im = imdilate(Im,strel('disk',round(kc_euclid/2)));
    output = output + Im;
end
end