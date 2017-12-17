function [Dxx,Dxy,Dyy] = Hessian2Dmod(I,sigma,gamma,tol)
% This function Hessian2 Filters the image with 2nd derivatives
% of a Gaussian with parameter Sigma. Modified from D.Kroon
% University of Twente (June 2009).
%
% [Dxx,Dxy,Dyy] = Hessian2Dmod(I,Sigma);
%
% INPUT:
% I ? The image, class preferable double or single
% sigma ? The sigma of the gaussian kernel used
%
% OUTPUT:
% Dxx, Dxy, Dyy ? The 2nd derivatives.

if nargin < 2
    sigma = 1;
    gamma = 1;
    tol = 10^(-3);
elseif nargin == 2
    gamma = 1;
    tol = 10^(-3);
elseif nargin == 3
    tol = 10^(-3);
end

% Make kernel coordinates
[X,Y] = ndgrid(-round(4 * sigma):round(4 * sigma));

% Build the gaussian 2nd derivatives filters

DGaussxx = -sigma^gamma * (sigma^2 - ...
    X.^2)/(2 * pi * sigma^6).* exp(-(X.^2+Y.^2)/(2 * sigma^2));
DGaussyy = - sigma^gamma * (sigma^2 - ...
    Y.^2)/(2 * pi * sigma^6).* exp(-(X.^2+Y.^2)/(2 * sigma^2));
DGaussxy = sigma^gamma * ...
    ((X.* Y/(2 * pi * sigma^6)).* exp(-(X.^2+Y.^2)/(2 * sigma^2)));

% Find the components of the Hessian using SVD,
% which is faster.
Dxx = convolve2(I,DGaussxx,'same',tol);
Dxy = convolve2(I,DGaussxy,'same',tol);
Dyy = convolve2(I,DGaussyy,'same',tol);

end