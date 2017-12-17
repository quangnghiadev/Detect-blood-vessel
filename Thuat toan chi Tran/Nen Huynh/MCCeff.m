function [ MCC,t ] = MCCeff( S,T )
% This function calculates the Matthews correlation coefficient
% (MCC) from the soft?thresholds S and T is the truth.
% INPUT:
% S ? The soft threshold. It must be nonnegative.
% T ? The truth (true or false).
% OUTPUT:
% MCC ? the vector MCC values.
% t ? the corresponding threshold values.

S = S(:); T = double(T(:));

N = length(S);

[SS,I] = sort(S?min(S)+1); TT = T(I);

t = [ 0; unique(SS) ];


[b,m,~] = unique(sort(SS .* TT));
b = [0; b]; m = [0; m];
TP = FillIn(t,b,N-m);
FN = sum(double(T)) - TP;

[b,m,~] = unique(sort(SS .* ~TT));
m = [0; m - m(1) * (b(1) == 0) ]; b = [0; b];
TN = FillIn(t,b,m);
FP = sum(double(~T)) - TN;

MCC = ((TP .* TN) - (FP .* FN))...
    ./sqrt((TP+FN) .* (TP+FP) .* (TN+FP) .* (TN+FN));

t = t + min(S) - 1;

end

function [ filled ] = FillIn( long,short,filler )
% Fills non?matching elements.

filled = long;

j = length(short);
for i = length(long) : -1 : 1
    filled(i) = filler(j);
    
    if long(i) == short(j)
        j = j-1;
    end
end

end