function [id] = find_point(Coor, P)
id = 0;
F1 = find(Coor(:,1)==P(1));
if(length(F1)>0)
     ST = [];
     for j=1:length(F1)
          ST = [ST; Coor(F1(j),2)]; 
     end
     F2 = find(ST==P(2));
     if(length(F2)==1)
          vt = F1(F2)+1;
          id = floor(vt/2);
     end
end
end