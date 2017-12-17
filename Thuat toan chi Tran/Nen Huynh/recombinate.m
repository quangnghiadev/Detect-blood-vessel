function J = recombinate(H)
% H: the images after DDFB, contruction and enhancement
% Output: Recombination

n = length(H);
sum = 0;
for i=1:n
    sum = sum + H{i};
end
J = sum./n;
%figure, imshow(J);