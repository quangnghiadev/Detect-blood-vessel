function [kc] = khoangcach(H1, H2)
Eucl =  pdist2(H1,H2);
kc = min(min(Eucl));
end