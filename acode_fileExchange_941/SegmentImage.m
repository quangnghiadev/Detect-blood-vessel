function bw_result = SegmentImage(  )
%SEGMENTIMAGE Summary of this function goes here
%   Detailed explanation goes here



clear
clc
oldpath = path;
path(oldpath,'C:\Users\Asus\Documents\Detect-blood-vessel\acode_fileExchange_941\For C#');
bw_result=imread('vessel.tif');
% bw_mask=imread('haha.tif');
% bw_mask=logical(bw_mask);
% ref_im=imread('86698558_frame35_output.jpg');
% %
% im=im(:,:,2);
% im=mat2gray(im).*mat2gray(bw_mask);
% im=imcomplement(im);% Assume vessels are lighter than background
% im=im2double(im);
% ref_bw=im2bw(ref_im,0.5);
% %%
% DEG_NUM=12;
% LEN_c=10; % nghia_dog: cái này chi?u dài c?a linear struct element - ch?nh s?a cái này v?i cái d??i
% LEN_o=20;
% LEN_diff=7;
% %
% ic1=reconstruction_by_dilation(im,LEN_c,DEG_NUM);
% io1=min_openings(im,LEN_o,20);
% 
% io1=min_openings(io1,LEN_o,20);
% % 
% iv=mat2gray(ic1-io1);
% imDiff=smooth_cross_section(iv,17,LEN_c);
% imL=reconstruction_by_dilation(imDiff,LEN_c,DEG_NUM);
% imF=reconstruction_by_erosion(imL,LEN_c,DEG_NUM);
% % 
% 
% % % %% Hysteresis thresholding
% TH_LOW=12;% nghia_dog cái này là ng??ng thích nghi nh? nh?t, gi?m xu?ng thì l?y dc nhi?u h?n
% TH_HIGH=40;
% min_obj=180;
% min_hole=10;
% %
% mask=im2bw(imF,TH_LOW/255);
% marker=im2bw(imF,TH_HIGH/255);
% bw_result=imreconstruct(marker,mask);
% %
% % some extra cleaning on the result.
% bw_result=bw_result& bw_mask;
% bw_result = clear_bw(bw_result, min_obj, min_hole);



end

