clear
clc
close all
im=imread('86698558_frame15.tiff');
% bw_mask=imread('retangle_8bitdept.tif');
bw_mask=imread('mask.tif');
bw_mask=logical(bw_mask);
ref_im=imread('86698558_frame15_output.jpg');
%
im=im(:,:,2);
im=mat2gray(im).*mat2gray(bw_mask);
im=imcomplement(im);% Assume vessels are lighter than background
im=im2double(im);
ref_bw=im2bw(ref_im,0.5);
%%
DEG_NUM=12;
LEN_c=10;
LEN_o=20;
LEN_diff=7;
%
ic1=reconstruction_by_dilation(im,LEN_c,DEG_NUM);
% figure,imshow(ic1);title('reconstruction_by_dilation');
io1=min_openings(im,LEN_o,20);

% ix = mat2gray(ic1-io1);


io1=min_openings(io1,LEN_o,20);
% figure,imshow(io1);title('min openning 20');
% 
iv=mat2gray(ic1-io1);

imDiff=smooth_cross_section(iv,17,LEN_c);
imL=reconstruction_by_dilation(imDiff,LEN_c,DEG_NUM);
imF=reconstruction_by_erosion(imL,LEN_c,DEG_NUM);
% 
figure,imshow(iv);title('iv');
% figure,imshow(imDiff);title('imDiff');
% figure,imshow(imL);title('imL');
% figure,imshow(imF);title('imF');
% % %% Hysteresis thresholding
TH_LOW=12;
TH_HIGH=27;  % 5_land  reduce this parameter to show blur vessel
min_obj=180;
min_hole=10;
%
mask=im2bw(imF,TH_LOW/255);
marker=im2bw(imF,TH_HIGH/255);
bw_result=imreconstruct(marker,mask);
% figure,imshow(bw_result);title('before');
%
% some extra cleaning on the result.
bw_result=bw_result& bw_mask;
bw_result = clear_bw(bw_result, min_obj, min_hole);
%
figure,imshow(bw_result);title('result');

% r=eval_metrics(bw_result,ref_bw,bw_mask);
% fprintf('TPR=%g\n FPR=%g\n accuracy=%g\n precision=%g\n',...
%     r(1),r(2),r(3),r(4));