function new_Coor = merge_coor(Coor, id1, id2)
P1 = Coor(2*id1-1:2*id1,:);
P2 = Coor(2*id2-1:2*id2,:);
Z = [0 0; 0 0];
P = [];
new_Coor = [Coor(1:2*id1-2,:); Z; Coor(2*id1+1:2*id2-2,:); Z; Coor(2*id2+1:end,:)];
if(sum(sum(P1(1,:)==P2(1,:)))==2)
    P = [P1(2,:); P2(2,:)];
elseif(sum(sum(P1(1,:)==P2(2,:)))==2)
    P = [P1(2,:); P2(1,:)];
elseif(sum(sum(P1(2,:)==P2(1,:)))==2)
    P = [P1(1,:); P2(2,:)];
elseif(sum(sum(P1(2,:)==P2(2,:)))==2)
    P = [P1(1,:); P2(1,:)];
end
new_Coor = [Coor(1:2*id1-2,:); P; Coor(2*id1+1:2*id2-2,:); Z; Coor(2*id2+1:end,:)];
end