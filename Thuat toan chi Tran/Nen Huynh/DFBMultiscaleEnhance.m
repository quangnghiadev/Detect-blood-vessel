function [ enhance ] = DFBMultiscaleEnhance( I,DDFBoption,midOption )
% This function calculates the accuracies from the
% soft?thresholds S and T is the truth.

% INPUT:
% I ? Grayscale image.
% DDFBoption ? Options for the DDFB vessel enhancement.
% .N ? the order of the diamond.
% .sigma ? the vector containing the scales.
% .beta ? the beta value for vessel
% enhancement.
% .c ? the c value for vessel enhancement.
% .LightonDark ? whether the vessels are
% lighter than its background.
% midOption ? Middle step between DDFB filtering and vessel
% enhancement options. Optional.
% .func ? The function applied to each of the
% directional images.
% ... ? Other parameters used by .func
% OUTPUT:
% enhance ? The enhancement output.

%% Setup DDFB options if not provided
if ~exist('DDFBoption','var') || isempty(DDFBoption)
    DDFBoption = struct('N',3,'sigma', 2 : 1 : 6,...
        'beta', 0.75,'c', 15,...
        'LightonDark',false);
end

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

%% Directionally filter the image
Filter = CreateDirectionalFilters(DDFBoption.N);
% size of filter = 16 

DirL = zeros(size(I,1),size(I,2),16);%16 is the number of directional images
% D = cell(1,16);
for k = 1 : 16
    DirL(:,:,k) = convolve2(I,Filter(:,:,k),'same',0.01);
    %figure, imshow(DirL(:,:,k),[]);
    %figure, imagesc(DirL(:,:,k),[min(min(DirL(:,:,k))), max(max(DirL(:,:,k)))]);
    %D{k} = imfilter(I,Filter(:,:,k),'circular','same');
    %figure, imshow(D{k});
end

%% mid?step filter
if exist('midOption','var') && ~isempty(midOption)
    for k = 1 : 16
        DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
        %figure, imagesc(DirL(:,:,k));
    end
end

%% Vessel Enhance
DirEnhance = DirectionalEnhance(DirL,DDFBoption);

%% Combine the enhancement
% enhance = max(DirEnhance,[],3);
enhance = mean(DirEnhance,3);

end