% a = imread('circlesBrightDark.png');
% BW = a < 100;
function [B] = chooseOrientation(BW2, mainAngle)

CC = bwconncomp(BW2);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);

stats = regionprops(CC,'Orientation');
t = struct2cell(stats);
orien = cell2mat(t);

orien(find(orien<0)) = orien(find(orien<0)) + 180;
pos = [find(orien<mainAngle-40), find(orien>mainAngle+40)];
B = BW2;
for i=1:length(pos)
    B(CC.PixelIdxList{pos(i)}) = 0;
end

figure, imshow(B);
end


% remove ko co torng accept
