function [ Accy,t ] = SoftAccuracy( S,T )
% This function calculates the accuracies from the soft?thresholds S and T
% is the truth.
% INPUT:
% S ? The soft threshold. It must be nonnegative.
% T ? The truth (true or false).
% OUTPUT:
% Accy ? The vector of accuracies.
% t ? The corresponding threshold values.
% EXAMPLE:
% N = 1000;
% S = floor(300 * rand(1,N));
% T = rand(1,N) > 0.5;
% Accy = SoftAccuracy( S,T );
% Temp = arrayfun(@(t) sum((S>t). * T) + sum((S ? t). * ¬T),...
% [?1 unique(S)])...
% /length(S);
% max(abs(Accy ? Temp))

S = S(:); T = double(T(:));

N = length(S);

[SS,I] = sort(S-min(S)+1); TT = T(I);

t = [ 0; unique(SS) ];

[b,m,~] = unique(sort(SS .* TT));

b = [0; b]; m = [0; m];
TP = FillIn(t,b,N-m);
% FN = sum(double(T)) ? TP;

[b,m,~] = unique(sort(SS .* ~TT));
m = [0; m - m(1) * (b(1) == 0) ]; b = [0; b];
TN = FillIn(t,b,m);
% FP = sum(double(¬T)) ? TN;

Accy = (TP + TN)/N;

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