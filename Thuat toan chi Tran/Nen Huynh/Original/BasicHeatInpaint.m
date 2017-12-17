function [ OutImage ] = BasicHeatInpaint( Image,interior )
% This function performs dissipation of intensity values from
% the boundary to the exterior. The image must be grayscale.
% This function requires the image processing toolbox
% (specifically, bwdist.m).
% INPUT:
% Image ? grayscale image.
% interior ? a binary marking the location of the interior to
% dissipate from.

% find the distance from the interior.
dst = bwdist(interior,'cityblock');

% Sort the distance to index from.
[sorted,ind] = sort(dst(:));
ind = ind(sorted > 0);

[I,J] = ind2sub(size(Image),ind);

OutImage = Image;

% Dissipate
for i = 1 : numel(ind)
    x = max(1,I(i)-1):min(size(OutImage,1),I(i)+1);
    y = max(1,J(i)-1):min(size(OutImage,2),J(i)+1);
    mark = double(interior(x,y));
    
    OutImage(I(i),J(i)) = ...
        sum(sum(OutImage(x,y).* mark))/sum(mark(:));
    interior(I(i),J(i)) = 1;
end

end