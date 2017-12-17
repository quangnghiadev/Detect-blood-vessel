function [Lambda1,Lambda2,Ix,Iy]=eig2image(Dxx,Dxy,Dyy)
% Tinh vecto rieng va tri rieng cua ma tran anh tu bo loc Guass.
% Sap xep cac tri rieng theo tri tuyet doi.
% 
% [Lambda1,Lambda2,Ix,Iy]=eig2image(Dxx,Dxy,Dyy)
% 
% input:    
%     Dxx,Dxy,Dyy     : Anh xam sau khi loc bang ham Guassian
% 
% output:
%     Lamda1  : Tri rieng truc giao nho
%     Lamda2  : Tri rieng truc giao lon
%     Ix      : Vector truc giao co tri rieng nho
%     Iy      : Vector truc giao co tri rieng lon.
% 
%      | Dxx  Dxy |
%      |          |
%      | Dxy  Dyy |

% Tinh vecto tri rieng nhu trong chung minh
% Ma tran doi xung luon cho tri rieng la so thuc va tuong ung la vector thuc
    tmp = sqrt((Dxx - Dyy).^2 + 4*Dxy.^2);
    v2x = 2*Dxy;
    v2y = Dyy - Dxx + tmp;
    
% Chuan hoa vector
    mag = sqrt(v2x.^2 + v2y.^2); 
    i = (mag ~= 0);
    v2x(i) = v2x(i)./mag(i);
    v2y(i) = v2y(i)./mag(i);

% The eigenvectors are orthogonal
    v1x = -v2y;
    v1y = v2x;

% Tinh tri rieng
    mu1 = 0.5*(Dxx + Dyy + tmp);
    mu2 = 0.5*(Dxx + Dyy - tmp);

% Sort eigen values by absolute value abs(Lambda1)<abs(Lambda2)
    check=abs(mu1)>abs(mu2);
    Lambda1=mu1; Lambda1(check)=mu2(check); % Sap xep cac gia tri truc giao nho vao Lamda1
    Lambda2=mu2; Lambda2(check)=mu1(check); % Sap xep cac gia tri truc giao lon vao Lamda2
    Ix=v1x; Ix(check)=v2x(check);           %   Vecto truc giao co tri rieng nho    
    Iy=v1y; Iy(check)=v2y(check);           %   Vecto truc giao co tri rieng lon