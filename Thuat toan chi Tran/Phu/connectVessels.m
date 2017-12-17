function Se = connectVessels(S, euclid)
Se = S;
% Start_End = startend_point(S)
Start_End = startend(S);
Coor = [];
for i=1:size(S,2)
     L = Se{i};
     Coor = [Coor; L(1,:); L(end,:)];
end
for i=1:size(Start_End,1)
    P = Start_End(i,:);
    id = find_point(Coor, P);
    if(id==0)
        continue;
    end
    LS = Se{id};
    Coo = [Coor(1:2*id-2,:); Coor(2*id+1:end,:)]; 
    H = set_point(S,id);
    kc_euclid = khoangcach(P,H);
    flag = 0; min_euclid = 0;
    if(kc_euclid<euclid)
        S_A = Coo(1,:);
        for j=2:size(Coo,1)
            A = Coo(j,:);
            ecli = sqrt(sum((P-A).^2));
            if(flag==0||ecli<min_euclid)
                min_euclid = ecli;
                flag = 1;
                S_A = A;
            end
        end
       if(sum(LS(1,:)==P)==2)
           LS(1,:) = S_A;
           Coor = [Coor(1:2*id-2,:); S_A ;Coor(2*id:end,:)]; 
       else
           LS(end,:) = S_A;
           Coor = [Coor(1:2*id-1,:); S_A; Coor(2*id+1:end,:)]; 
       end
       Se{id} = LS;
    end
end
end