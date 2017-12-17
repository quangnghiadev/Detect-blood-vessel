function [ Y ] = upsample2D(M,X,pad)
% This function downsamples by matrix M on grayscale image X.
% INPUT:
% M ? The downsample matrix.
% X ? The grayscale image.
% pad ? Whether or not to pad the unknown. OPTIONAL.
% OUTPUT:
% Y ? The downsampled image.

% Get the center of the image.
center = floor(size(X)/2)+1;

% Grid the image X with (0,0) being the center.
[i,j] = ndgrid(1-center(1):size(X,1)-center(1),...
    -center(2):size(X,2)-center(2));
i = reshape(i,1,[]); j = reshape(j,1,[]);

% Rotate the grid.
sample = M * [i; j];
x = sample(1,:);
y = sample(2,:);

if isempty(pad) || ~pad
    % Find the half indices with zeros.
    boolean = rem(x,1) == 0 & rem(y,1) == 0 ...
        & x >= 1 - center(1) & x <= size(X,1)-center(1) ...
        & y >= 1 - center(2) & y <= size(X,2)-center(2);
    
    
    % Only keep the integer indices.
    I = sub2ind(size(X),i(boolean) + center(1),...
        j(boolean) + center(2));
    J = sub2ind(size(X),x(boolean) + center(1),...
        y(boolean) + center(2));
    
    % Substitute using reindexing.
    Y = zeros(size(X));
    Y(J) = X(I);
else
    % Find the half indices with zeros.
    boolean = rem(x,1) == 0 & rem(y,1) == 0;
    
    minx = min(x(:)); maxx = max(x(:));
    miny = min(y(:)); maxy = max(y(:));
    m = min(minx,miny); M = max(maxx,maxy);
    
    Y = zeros(M - m + 1);
    
    % Only keep the integer indices.
    I = sub2ind(size(X),i(boolean) + center(1),...
        j(boolean) + center(2));
    J = sub2ind(size(Y),x(boolean) - m + 1,...
        y(boolean) - m + 1);
    
    % Substitute using reindexing.
    Y(J) = X(I);
end

end