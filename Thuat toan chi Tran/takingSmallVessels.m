% Nen Huynh 16 directional images
% replace with takingPV

function [SV] = takingSmallVessels(I) 
%% A. Setup the parameters

DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Gaussian',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);


if ~isfield(DDFBoption,'N')
    DDFBoption.N = 3;
end

if ~isfield(DDFBoption,'sigma')
    DDFBoption.sigma = 2 : 1 : 6;
end

if ~isfield(DDFBoption,'beta')
    DDFBoption.beta = 0.75;
end

if ~isfield(DDFBoption,'c')
    DDFBoption.c = 15;
end

if ~isfield(DDFBoption,'LightonDark')
    DDFBoption.LightonDark = false;
end


%% Vessel extraction database
% I = imread('test2_2.jpg');
% I = imcrop(I);
% figure, imshow(I);
% if length(size(I))==3
%     I = rgb2gray(I);
% end
% I = im2double(I);
% load removePV
% I = im2double(croppedI);

%% Preprocessing
% interior = interiorBW(I);
% 
% I = BasicHeatInpaint(I,interior);%%???
% I = imcrop(I);
% I = histeq(I);
I = imadjust(I);
figure, imshow(I);

Filter = CreateDirectionalFilters(DDFBoption.N);

DirL = zeros(size(I,1),size(I,2),16);% size of filter = 16
for k = 1 : 16
    DirL(:,:,k) = convolve2(I,Filter(:,:,k),'same',0.01);
    %figure, imshow(DirL(:,:,k),[]);
end

if exist('midOption','var') && ~isempty(midOption)
    for k = 1 : 16
        DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
        %figure, imagesc(DirL(:,:,k));
    end
end

DirEnhance = DirectionalEnhance(DirL,DDFBoption);

enhance = mean(DirEnhance,3);

%% Display
% Convert to unit8
A = enhance*255/max(max(enhance));
% figure, imshow(A,[]);
% figure, imagesc(A,[min(min(A)), max(max(A))]);

% Display in 3D and use this image for next step
cmap = colormap;
res = grs2rgb(A,cmap);
% figure, imshow(res,[]);

% Using Otsu method 2 times, 3 times, 4 times
ImgOtsu = cell(1,3);
for i=1:3
   ImgOtsu{i} = otsu(res,i+1); 
end

figure,
subplot(1,4,1); imshow(res,[]); title('Original image');
subplot(1,4,2); imshow(ImgOtsu{1},[]); title('Otsu 2 times');
subplot(1,4,3); imshow(ImgOtsu{2},[]); title('Otsu 3 times');
subplot(1,4,4); imshow(ImgOtsu{3},[]); title('Otsu 4 times');

% Convert to binary images
OutputOtsu = ImgOtsu;

OutputOtsu{1}(OutputOtsu{1}<2) = 0;
OutputOtsu{1}(OutputOtsu{1}~=0) = 1;
OutputOtsu{2}(OutputOtsu{2}<2) = 0;
OutputOtsu{2}(OutputOtsu{2}~=0) = 1;
OutputOtsu{3}(OutputOtsu{3}<2) = 0;
OutputOtsu{3}(OutputOtsu{3}~=0) = 1;

% Imshow recombination of Otsu n times images
SV = (OutputOtsu{1} | OutputOtsu{2}) | OutputOtsu{3};
figure, imshow(SV,[]); title('Recombination of Otsu n times images');

end