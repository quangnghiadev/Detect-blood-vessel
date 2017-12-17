function [Dxx,Dxy,Dyy] = Hessian(I,Sigma)

if nargin < 2, Sigma = 1; end

   [X,Y]   = ndgrid(-round(3*Sigma):round(3*Sigma));

%   Chung minh cong thuc trong giay nhap.
DGaussxx = 1/(2*pi*Sigma^4) * (X.^2/Sigma^2 - 1) .* exp(-(X.^2 + Y.^2)/(2*Sigma^2));
DGaussxy = 1/(2*pi*Sigma^6) * (X .* Y)           .* exp(-(X.^2 + Y.^2)/(2*Sigma^2));
DGaussyy = DGaussxx';

%   Loc theo mat na cua ham Guass trong khong gian scale tuyen tinh.
Dxx = imfilter(I,DGaussxx,'conv');
Dxy = imfilter(I,DGaussxy,'conv');
Dyy = imfilter(I,DGaussyy,'conv');
