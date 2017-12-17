function Start_End = startend(S)
Coor = []; Start_End = [];
for i=1:size(S,2)
    L = S{i};
    Coor = [Coor; L(1,:); L(end,:)];
end
for i=1:size(Coor,1)
    P = Coor(i,:);
    id = finds_point(Coor, P);
    if(length(id)==1)
        Start_End = [Start_End; P];
    end
end
end