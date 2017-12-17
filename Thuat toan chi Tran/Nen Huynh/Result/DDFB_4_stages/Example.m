clc;
close all ,clear all;

I = imread('test.jpg');
figure, imshow(I); 
M = homoFilter2(I);
figure, imshow(uint8(M)); 

%xx = xx(100:300,100:300);
% xx = zeros(50);
% x0 = 25;y0=25;
% for i = 0:4,
%     %xx(5, 10+i) = 100;
%     xx(x0-1*i,y0-5*i) = 100;
% end
% imshow(xx,[]);title('org im');

% [t1,t2,t3,t4,t5,t6,t7,t8] = ddfb_4_stages(xx,3,52); 
% t = {t1 t2 t3 t4 t5 t6 t7 t8};
SB = ddfb_4_stages(I,3,52); %contains 8 directional images

K = cell(1,length(SB));
H = cell(1,length(SB));
for i=1:length(SB)
    figure; imshow(SB{i}, []); title(['Direction #' num2str(i)]);
    K{i} = homoFilter(SB{i});
    %figure, imagesc(K, [min(K{i}(:)), max(K{i}(:))]);
    %title(['Homomorphic filtering #' num2str(i)]);
    H{i} = FrangiFilter2D(K{i});
    %figure; imshow(H{i}, []); title(['Frangi Filter #' num2str(i)]);
end

% imshowpair(SB{1},K{1},'montage');

J = recombinate(H); 
figure, imagesc(J, [min(J(:)), max(J(:))]);
title( 'Recombination' ) ;
axis image off;
colormap(gray);
%figure, imshow(uint8(J)); 

% IJ = homoFilter(I);
% imagesc(IJ, [min(IJ(:)), max(IJ(:))]);
% title( '2' ) ;
% axis image off;
% colormap(gray);


% for i = 0:4,
%     mt = [];
%     for ii=1:8, 
%         mt = [mt t{ii}(x0-1*i,y0-5*i)];
%     end
%     mtr(i+1,:) = mt;
% end
% mtr = int32(mtr*100.0);
