function Se = segment_coor(S, Img)
dem = 1;
Se = cell(1);
while(kichthuoc(Se)~=length(S))
    SR = remain_segment(S, Se);
    Start_End = startend(SR);
    Seed = seedPoint(Start_End, SR, Img);
    Coor = [];
    for i=1:length(SR)
         L = SR{i};
         Coor = [Coor; L(1,:); L(end,:)];
    end
    id = find_point(Coor, Seed);
    ST = SR{id}; vecto = [0 0];
    LT = Coor(2*id-1:2*id,:);
    if(LT(1,1)==Seed(1)&&LT(1,2)==Seed(2))
        vecto = ST(max(min(10,end),min(5,end)),:)-Seed;
        vecto = vecto/max(abs(vecto));
    else
        vecto = ST(min(max(1,end-5),max(1,end-10)),:)-Seed;
        vecto = vecto/max(abs(vecto));
    end
    Se{dem} = getsegment(SR, cell(1), Coor, Seed, vecto);  % viet ham nay
    Se{dem} = loaibo_thua(Se{dem});
    dem = dem+1;
end 