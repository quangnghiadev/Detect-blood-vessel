function [new_Coor] = sub_not_coor(Coor)
new_Coor = [];
n = size(Coor,1);
for i=1:n
    P1 = Coor(i,:);
    id = finds_point(Coor, P1);
    if(length(id)==2&&P1(1)~=0&&P1(2)~=0)
        Coor = merge_coor(Coor, id(1), id(2));
    end
end
[x,y] = find(Coor==0);
Coor(x,:) = [];
%new_Coor = [new_Coor; Coor];
new_Coor = Coor;
end