function detect_level(Seed,Coor,lev)
text(Seed(2),Seed(1),num2str(lev),'Color','r');
id_seed = find_point(Coor, Seed);
if(id_seed==0)
    return;
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
    detect_level(Next_Seed,C,lev+1)
end
if(length(id)<=0)
    detect_level(Next_Seed,[0 0],lev+1)
end

end