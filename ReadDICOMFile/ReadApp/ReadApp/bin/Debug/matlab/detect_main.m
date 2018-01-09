clear
clc
close all
%% Read file
im=imread('source.tif');
bw_mask=imread('mask.tif');
bw_mask=logical(bw_mask);                                                   %Chuyen du lieu anh mask qua dang logic 1 và 0, khac 0 -> 1,  bang 0 -> 0
                                                                            %Vi trang 255 > 0, den 0 = 0 => mau sac anh mask ko thay doi gi (nhung gia tri tung pixel thi thay doi)
%% Pre-progressing
im=im(:,:,2);                                                               %So hang - so cot - so thu tu kenh (1-2-3 tuong ung Red-Green-Blue). 
                                                                            %Anh nay goi la anh 3D true color. Lay ngau nhien 1 page, dong lenh nay co tac dung voi anh retina
im=mat2gray(im).*mat2gray(bw_mask);                                         %Phep nhan element by element cua 2 ma tran grayscale (xam). Chuyen ve anh xam de xac dinh muc do xam, so sanh do xam cua mach voi nen
                                                                            %Anh goc la 3 mau nen can chuyen ve mot mau
                                                                            %Ket qua nhan duoc la anh mask se che di nhung doi tuong ko can thiet (vi mau den la so 0, 0 nhan cho bat cu so nao cung la 0)
                                                                            %Vung mau trang la so 1 -> giu nguyen gia tri
im=imcomplement(im);                                                        %Dao nghich do tuong phan - vi nhung buoc sau nay minh se xet nhung diem co do sang cao se thuoc mach mau
im=im2double(im);                                                           %Dam bao anh sau qua trinh tien xu ly la mot ma tran kieu double

%% Progressing
DEG_NUM=12;                                                                 
LEN_c=10;
LEN_o=20;
LEN_diff=17;
ic1=reconstruction_by_dilation(im,LEN_c,DEG_NUM);
% figure,imshow(ic1);title('reconstruction_by_dilation');
io1=min_openings(im,LEN_o,20);
% figure,imshow(io1);title('min openning 20');
iv=mat2gray(ic1-io1);
% figure,imshow(iv);title('iv');
imDiff=smooth_cross_section(iv,LEN_diff,LEN_c);
% figure,imshow(imDiff);title('imDiff');
imL=reconstruction_by_dilation(imDiff,LEN_c,DEG_NUM);
% figure,imshow(imL);title('imL');
imF=reconstruction_by_erosion(imL,LEN_c,DEG_NUM);
% figure,imshow(imF);title('imF');
%% Threshold
TH_LOW=12;
TH_HIGH=33;
min_obj=180;
min_hole=10;
mask=im2bw(imF,TH_LOW/255);
marker=im2bw(imF,TH_HIGH/255);
bw_result=imreconstruct(marker,mask);
% figure,imshow(bw_result);title('before');
%% Some extra cleaning on the result.
bw_result=bw_result& bw_mask;
bw_result = clear_bw(bw_result, min_obj, min_hole);
figure,imshow(bw_result);title('result');
imwrite(bw_result,'data\result.tif');