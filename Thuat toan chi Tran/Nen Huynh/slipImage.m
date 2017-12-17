%divide an image to 9 parts

clc; clear all; close all;
I = imread('vessels.jpg');
if length(size(I))==3
    I = rgb2gray(I);
end
figure, imshow(I);

%%
nn = size(I,1);
mm = size(I,2);
h = floor(nn/3);
k = floor(mm/3);
J = cell(1,9);
count = 1;
for i = 1:h:nn
    if i~=nn
        for j = 1:k:mm
            if j~=mm
                A = imcrop(I,[i j h k]);
                J{count} = A;
                figure, imshow(A);
                count = count+1;
            end
        end
    end
end

%% process
%choose 4 main directions of each part
DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Butterworth',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);


L = cell(1,9);

for i=1:9
    % DDFB
    m = 3;
    DirL = DDFB(J{i},m,8);
    
    n = 2^m;
    % Homomorphic filter
    if exist('midOption','var') && ~isempty(midOption)
        for k = 1 : n
            DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
%             figure, imagesc(DirL(:,:,k));
%             figure, imshow(DirL(:,:,k), []);
        end
    end
    
    DirEnhance = DirectionalEnhance(DirL,DDFBoption);
    K = zeros(1,n);
    for k = 1 : n
%         figure, imshow(DirEnhance(:,:,k), []);
%         figure, imagesc(DirEnhance(:,:,k));
%         Number of nonzero matrix elements
        K(k) = nnz(DirEnhance(:,:,k));
    end
    
    %choosing
    % S chua tri so cua 4 anh con co phan tu khac 0 lon nhat
    [B vt] = sort(K,'descend');
    
    sz = 4;
    S = vt(1:sz);
    S = sort(S);
    %delete 
    A = DirEnhance(:,:,S);
    enhance = mean(A,3);
    figure, imshow(enhance,[]);
    %figure, imagesc(enhance);
    
    ee = mean(DirEnhance,3);
    figure, imshow(ee,[]);
    %figure, imagesc(ee);
    
    L{i} = enhance;
    
end

%% merge 9 parts
H = [L{1} L{4} L{7}; L{2} L{5} L{8}; L{3} L{6} L{9}];
figure, imshow(H,[]);
figure, imagesc(H);
