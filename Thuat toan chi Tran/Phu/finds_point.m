function [id] = finds_point(Coor, P)
id = [];
F1 = find(Coor(:,1)==P(1));
if(length(F1)>0)
     ST = [];
     for j=1:length(F1)
          ST = [ST; Coor(F1(j),2)]; 
     end
     F2 = find(ST==P(2));
     if(length(F2)>0)
         for k=1:length(F2)
             vt = F1(F2(k))+1;
             id = [id floor(vt/2)];
         end
     end
end
end