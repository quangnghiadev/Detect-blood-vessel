% Nen Huynh
% function[enhance] = run(I)
% 16 directional images

clc; clear all; close all;

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
I = imread('test2.jpg');
I = imcrop(I);
figure, imshow(I);
if length(size(I))==3
    I = rgb2gray(I);
end
I = im2double(I);
% load removePV
% I = im2double(croppedI);

%% Preprocessing
% interior = interiorBW(I);
% 
% I = BasicHeatInpaint(I,interior);%%???
% I = imcrop(I);
% I = histeq(I);
figure, imshow(I);

% I = imcrop(I,[110.5 55.5 293 363]);
%test2,[110.5 55.5 293 363]);%[96.5 68.5 325 332] test3
% figure, imshow(I);

%DATA{1} = struct('I',I);
%% DDFB Homomorphic mid
% for i=10:80
%
%     DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
%         'beta', 1,'gamma', i,...
%         'DarkonLight',false);
%% Divite 9 parts
% nn = size(I,1);
% mm = size(I,2);
% h = floor(nn/3);
% k = floor(mm/3);
% J = cell(1,9);
% count = 1;
% for i = 1:h:nn
%     if i~=nn
%         for j = 1:k:mm
%             if j~=mm
%                 A = imcrop(I,[i j h k]);
%                 J{count} = A;
%                 figure, imshow(A);
%                 count = count+1;
%             end
%         end
%     end
% end
% L = cell(1,9);
% for k=1:9
%     Temp = struct();
%     
%     Temp.DDFBoption = DDFBoption;
%     
%     Temp.midOption = midOption;
%     
%     enhance = DFBMultiscaleEnhance(J{k},Temp.DDFBoption,Temp.midOption);
%     
%     Temp.enhance = enhance;
%     
%     L{k} = enhance;
% end

Filter = CreateDirectionalFilters(DDFBoption.N);

DirL = zeros(size(I,1),size(I,2),16);% size of filter = 16
% D = cell(1,16);
for k = 1 : 16
    DirL(:,:,k) = convolve2(I,Filter(:,:,k),'same',0.01);
    %figure, imagesc(Filter(:,:,k));
    %figure, imshow(DirL(:,:,k),[]);
    %D{k} = imfilter(I,Filter(:,:,k),'circular','same');
    %figure, imshow(D{k});
end

if exist('midOption','var') && ~isempty(midOption)
    for k = 1 : 16
        DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
        %figure, imagesc(DirL(:,:,k));
    end
end

DirEnhance = DirectionalEnhance(DirL,DDFBoption);

enhance = mean(DirEnhance,3);
%% merge 9 parts
% H = [L{1} L{4} L{7}; L{2} L{5} L{8}; L{3} L{6} L{9}];
% figure, imshow(H,[]);
% figure, imagesc(H);

%% Display
% figure, imagesc(enhance,[min(min(enhance)), max(max(enhance))]);
colorbar;
axis off

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

% figure,
% subplot(1,2,1); imshow(I,[]); title('Original image');
% subplot(1,2,2); imshow(ImgOtsu{3},[]); title('Otsu 4 times');

% Convert to binary images
OutputOtsu = ImgOtsu;

OutputOtsu{1}(OutputOtsu{1}<2) = 0;
OutputOtsu{1}(OutputOtsu{1}~=0) = 1;
OutputOtsu{2}(OutputOtsu{2}<2) = 0;
OutputOtsu{2}(OutputOtsu{2}~=0) = 1;
OutputOtsu{3}(OutputOtsu{3}<2) = 0;
OutputOtsu{3}(OutputOtsu{3}~=0) = 1;

% Imshow recombination of Otsu n times iamges
A = (OutputOtsu{1} | OutputOtsu{2}) | OutputOtsu{3};
figure, imshow(A,[]);

% cut phan du thua
position = [83.5 2.5 429 425];
A = imcrop(A, position);
% A = imfill(A);
figure, imshow(A,[]);


I2 = imcrop(I, position);
figure, imshow(I2,[]);

% I2 = new I; A = new interior;



                                                                            
 