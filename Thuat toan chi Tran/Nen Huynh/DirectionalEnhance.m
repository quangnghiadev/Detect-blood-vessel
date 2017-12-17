function [ directEnhance ] = DirectionalEnhance( ...
    directImg,option )
% This function enhances each of the directional vessel images.
% INPUT:
% directImg ? The cell of directional vessels images.
% option ? Options for the DDFB vessel enhancement.
% .N ? the order of the diamond.
% .sigma ? the vector containing the scales.
% .beta ? the beta value for vessel enhancement.
% .c ? the c value for vessel enhancement.
% .LightonDark ? whether the vessels are
% lighter than its background.
% OUTPUT:
% directEnhance ? a #?#?16 matrix of vessel enhancement on
% each of the directional images.

% Number of directional filters
n = size(directImg,3);

% angle of the filters.
theta = pi/(2 * n) : pi/n : (2 * n-1) * pi/(2 * n);

temp = cell(n,1);

if option.LightonDark
    for i = 1 : n
        % Directional vessel enhance on light vessels.
        temp{i} = DirectionalEnhanceLightonDark(...
            directImg(:,:,i),option,theta(i));
    end
else
    for i = 1 : n
        % Directional vessel enhance on dark vessels.
        temp{i} = DirectionalEnhanceDarkonLight(directImg(:,:,i),option,theta(i));
    end
end

% Combine the directional vessel enhancements.
directEnhance = cat(3,temp{:});

end


function [outImg] = DirectionalEnhanceLightonDark(Img,option,angle)
% This function performs the light?on?dark enhancement version.

outImg = zeros(size(Img));
for sigma = option.sigma
    [Dxx,Dxy,Dyy] = Hessian2Dmod(Img,sigma);
    h11 = Dxx * cos(angle)^2 + Dxy * sin(2*angle) + Dyy * sin(angle)^2;
    h22 = Dxx * sin(angle)^2 - Dxy * sin(2*angle) + Dyy * cos(angle)^2;
    S = sqrt(h11.^2 + h22.^2);
    R = h11./h22;
    temp = double(h22 < 0).* (exp(-R.^2/(2 * option.beta^2))...
        .* (1-exp(-S.^2/(2 * option.c^2))));
    outImg = double(temp > outImg).* (temp - outImg) + outImg;
end

end


function [outImg] = DirectionalEnhanceDarkonLight(Img,option,angle)
% This function performs the dark?on?light enhancement version.

outImg = zeros(size(Img));
for sigma = option.sigma
    [Dxx,Dxy,Dyy] = Hessian2Dmod(Img,sigma);
    h11 = Dxx * cos(angle)^2 + Dxy * sin(2*angle) + Dyy * sin(angle)^2;
    h22 = Dxx * sin(angle)^2 - Dxy * sin(2*angle) + Dyy * cos(angle)^2;
    S = sqrt(h11.^2 + h22.^2);
    R = h11./h22;
    temp = double(h22 > 0).* (exp(-(R.^2/(2 * option.beta^2)))...
        .* (1-exp(-S.^2/(2 * option.c^2))));
    outImg = double(temp > outImg).* (temp - outImg) + outImg;
    
%     figure, imshow(outImg,[]);
end

end