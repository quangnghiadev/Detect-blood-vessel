function [ Filter ] = CreateDirectionalFilters( N,sz,version )
% This function creates the Decimation?free directional filter ...
% bank filters
% used in paper: Truc et. al., Vessel enhancement filter using ...
% directional filter bank.
% INPUT:
% N ? The diamond filter order.
% sz [m n] ? The size of the wedge filters. OPTIONAL. Truc page 110
% version ? The version of hourglass. OPTIONAL.
% v1,v1T,v190,v1?90;v2,v2T,v290,v2?90.
% OUTPUT:
% Filters ? an m?by?n?by?16 dimensional matrix with the third
% dimension indexed for each of the wedge?shaped ...
% filters.

if N < 0
    error('N must be a positive integer');  
end

if ~exist('sz','var') || isempty(sz)
    sz = 8 * (N-1); % nonzero Filter window is 8(N?1), with +8 extra padded zeros.
end

if ~exist('version','var')
    version = 'v1T';
end

% Quincunx
Q = [1 -1; 1 1];

% Sheer matrices
R1 = [1 0; -1 1]; R1T = R1';
R2 = [1 1; 0 1]; R2T = R2';

%% Create Level 1 (Hourglass) Filters
[ h0,h1 ] = hourglass2D( N,version );

range = floor([sz sz]/2) + 1 - floor([N N]/2) ...
    : floor([sz sz]/2) + ceil([N N]/2);

H0 = zeros(sz);
H0(range,range) = h0;

H1 = zeros(sz);
H1(range,range) = h1;

% [ H0,H1 ] = hourglass2D( N );

%% Create Level 2 Filters
H0Q = upsample2D(Q,H0,false);
H1Q = upsample2D(Q,H1,false);

%% Create the 4 Wedges
Filter2 = cat(3,...
    conv2(H0,H0Q,'same'),...
    conv2(H0,H1Q,'same'),...
    conv2(H1,H1Q,'same'),...
    conv2(H1,H0Q,'same'));

%% Create Level 3 Filters
H0R1QQ = upsample2D(R2 * Q * Q,H0,false);
H1R1QQ = upsample2D(R2 * Q * Q,H1,false);

H0R1TQQ = upsample2D(R2T * Q * Q,H0,false);
H1R1TQQ = upsample2D(R2T * Q * Q,H1,false);

H0R2QQ = upsample2D(R1 * Q * Q,H0,false);

H1R2QQ = upsample2D(R1 * Q * Q,H1,false);

H0R2TQQ = upsample2D(R1T * Q * Q,H0,false);
H1R2TQQ = upsample2D(R1T * Q * Q,H1,false);

%% Create the 8 Wedges
Filter3 = cat(3,...
    conv2(Filter2(:,:,1),H0R1QQ,'same'),...
    conv2(Filter2(:,:,1),H1R1QQ,'same'),...
    conv2(Filter2(:,:,2),H1R2TQQ,'same'),...
    conv2(Filter2(:,:,2),H0R2TQQ,'same'),...
    ...
    conv2(Filter2(:,:,3),H1R2QQ,'same'),...
    conv2(Filter2(:,:,3),H0R2QQ,'same'),...
    conv2(Filter2(:,:,4),H0R1TQQ,'same'),...
    conv2(Filter2(:,:,4),H1R1TQQ,'same'));

%% Create Level 4 Filters
H0R1QR1QQ = upsample2D(R2 * Q * R2 * Q * Q,H0,false);
H1R1QR1QQ = upsample2D(R2 * Q * R2 * Q * Q,H1,false);

H0R1QR2TQQ = upsample2D(R2 * Q * R1T * Q * Q,H0,false);
H1R1QR2TQQ = upsample2D(R2 * Q * R1T * Q * Q,H1,false);

% ??
H0R2QR2QQ = upsample2D(R1 * Q * R1 * Q * Q,H0,false);
H1R2QR2QQ = upsample2D(R1 * Q * R1 * Q * Q,H1,false);

H0R2QR1TQQ = upsample2D(R1 * Q * R2T * Q * Q,H0,false);
H1R2QR1TQQ = upsample2D(R1 * Q * R2T * Q * Q,H1,false);

% ??
H0R1TQR1QQ = upsample2D(R2T * Q * R2 * Q * Q,H0,false);
H1R1TQR1QQ = upsample2D(R2T * Q * R2 * Q * Q,H1,false);

H0R1TQR2TQQ = upsample2D(R2T * Q * R1T * Q * Q,H0,false);
H1R1TQR2TQQ = upsample2D(R2T * Q * R1T * Q * Q,H1,false);

% ??
H0R2TQR2QQ = upsample2D(R1T * Q * R1 * Q * Q,H0,false);
H1R2TQR2QQ = upsample2D(R1T * Q * R1 * Q * Q,H1,false);

H0R2TQR1TQQ = upsample2D(R1T * Q * R2T * Q * Q,H0,false);
H1R2TQR1TQQ = upsample2D(R1T * Q * R2T * Q * Q,H1,false);

%% Create the 16 Wedges
Filter4 = cat(3,...
    conv2(Filter3(:,:,2),H0R1QR2TQQ,'same'),...
    conv2(Filter3(:,:,2),H1R1QR2TQQ,'same'),...
    conv2(Filter3(:,:,1),H1R1QR1QQ,'same'),...
    conv2(Filter3(:,:,1),H0R1QR1QQ,'same'),...
    ...
    conv2(Filter3(:,:,8),H0R1TQR2TQQ,'same'),...
    conv2(Filter3(:,:,8),H1R1TQR2TQQ,'same'),...
    conv2(Filter3(:,:,7),H1R1TQR1QQ,'same'),...
    conv2(Filter3(:,:,7),H0R1TQR1QQ,'same'),...
    ...
    conv2(Filter3(:,:,6),H1R2QR1TQQ,'same'),...
    conv2(Filter3(:,:,6),H0R2QR1TQQ,'same'),...
    conv2(Filter3(:,:,5),H0R2QR2QQ,'same'),...
    conv2(Filter3(:,:,5),H1R2QR2QQ,'same'),...
    ...
    conv2(Filter3(:,:,4),H1R2TQR1TQQ,'same'),...
    conv2(Filter3(:,:,4),H0R2TQR1TQQ,'same'),...
    conv2(Filter3(:,:,3),H0R2TQR2QQ,'same'),...
    conv2(Filter3(:,:,3),H1R2TQR2QQ,'same'));...
    
Filter = Filter4;

end