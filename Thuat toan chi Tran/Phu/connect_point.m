function Se = connect_point(S, Coor, Seed, euclid)
Se = S;
n = size(S,2);
id_seed = find_point(Coor, Seed);
if(id_seed==0)
    return;
end
for i=1:n
    L = Se{i};
    L1 = L(1,:);
    L2 = L(end,:);
    kc1 = sqrt(sum((Seed-L1).^2));
    kc2 = sqrt(sum((Seed-L2).^2));
    if(kc1<euclid)
        L(1,:) = Seed;
    end
    if(kc2<euclid)
        L(end,:) = Seed;
    end
    Se{i} = L;
end
L = Coor(2*id_seed-1:2*id_seed,:);
if(L(1,1)==Seed(1)&&L(1,2)==Seed(2))
    Next_Seed = L(2,:);
else
    Next_Seed = L(1,:);
end
Coo = [Coor(1:2*id_seed-2,:); Coor(2*id_seed+1:end,:)]; 
Co = [Coor(1:2*id_seed-2,:); Coor(2*id_seed+1:end,:)]; 
id = finds_point(Coo, Next_Seed);
it = finds_point(Co, Next_Seed);
while(length(it)>0)
    Co = [Co(1:2*it(1)-2,:); Co(2*it(1)+1:end,:)];
    it = finds_point(Co, Next_Seed);
end
for i=1:length(id)
    it = id(i);
    C = [Coo(2*it-1:2*it,:); Co];
    Se = connect_point(Se, C, Next_Seed, euclid);
end
if(length(id)<=0)
    Se = connect_point(Se, [0 0], Next_Seed, euclid);
end
end





