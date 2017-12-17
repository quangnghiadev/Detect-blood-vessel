function [XY] = getxy(n,P)
X = floor(P/n)+1; Y = mod(P,n)+1;
XY = [Y X];
end