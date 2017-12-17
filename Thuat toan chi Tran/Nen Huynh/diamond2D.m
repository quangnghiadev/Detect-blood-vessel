function [ diamond ] = diamond2D( N )
% This function creates the diamond filter. Studied from
% Truc et. al.'s code.
% INPUT:
% N ? The order of the diamond filter.
% OUTPUT:
% diamond ? the diamond filter output.
% 1?D step (freq domain) function
s = fir1(N-1, .5);

% 2D step function
s2D = s' * s;

% Checkerboard (freq domain) function
[X,Y] = ndgrid(1:N,1:N);
checker = (1 + (-1).^(X+Y)).* s2D;

% Downsample in spatial is upsample in frequency
diamond = downsample2D([1 -1; 1 1],checker);

end