function ratio = calculate_accuracy()
%% Add necessary paths
addpath(genpath('./data'));
%%
img = im2bw(imread('result.tif'));
truth_img = im2bw(imread('groundtruth.jpg'));
truth_img=im2bw(truth_img,0.5);
 P = find(truth_img == 1 & img == 1);
 P1 = find(truth_img == 1);
 P2= find(img == 1);
    
 common = size(P,1);
 cm = size(P1,1);
 co = size(P2,1);
 ratio = (2*common)/(cm+co);

end