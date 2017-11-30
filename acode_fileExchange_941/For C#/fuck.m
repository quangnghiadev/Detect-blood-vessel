function im=fuck()
%
% $$I_1=R_{I_o}\left (max\left\{\gamma_{B_i} (I_o)\right\}\right), & i=1,...,12$$ 
% INPUT: 
%     IM (complemented green channel of a color retina image)
%     LEN (defualt: 11)
%     DEG_NUM (defualt:12)
% OUTPUT: 
%     imC2 
oldpath = path;
path(oldpath,'C:\Users\Asus\Documents\Detect-blood-vessel\acode_fileExchange_941\For C#');
    LEN=11;

    DEG_NUM=12;
im = imread('vessel.tif');
 DEG=0;
    se=strel('line',LEN,0);
    
im = imclose(im,se);
end