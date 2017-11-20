clear
clc

addpath(genpath('./data'));
addpath(genpath('./functions'));

im=imread('86698558_frame35.jpg');
bw_mask=imread('vessel_mask.gif');
bw_mask=logical(bw_mask);
ref_im=imread('86698558_frame35_output.jpg');
%
im=im(:,:,2);
im=mat2gray(im).*mat2gray(bw_mask);
im=imcomplement(im);% Assume vessels are lighter than background
im=im2double(im);

DEG_NUM=12;
LEN_c=10; % nghia_dog: cái này chi?u dài c?a linear struct element - ch?nh s?a cái này v?i cái d??i
LEN_o=20;
LEN_diff=7;
%
ic1=reconstruction_by_dilation(im,LEN_c,DEG_NUM);
figure,imshow(ic1);title('reconstruction_by_dilation');
io1=min_openings(im,LEN_o,20);
figure,imshow(io1);title('min openning 20');
io1=min_openings(io1,LEN_o,20);
figure,imshow(io1);title('min openning 20');


% 
iv=mat2gray(ic1-io1);
figure,imshow(iv);title('iv');