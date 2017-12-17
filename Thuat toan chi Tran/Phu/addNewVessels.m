clc; clear all; close all;


load straightlines
load junctions
load PV

Img = imread('vessels.jpg');
if(length(size(Img))==3)
    Img = rgb2gray(Img);
end
% removing the duplicated junctions
[junc, ia, ic] = unique(Coor, 'rows', 'stable');
n = length(junc);
junc = [junc, zeros(n,2)];
% find father of each junction
k = 1;
junc(1,4) = 1;
for i=2:n
    c = ic(k:k+1);
    junc(i,3) = min(c);
    % level of junction
    % level con = level cha + 1
    junc(i,4) = junc(junc(i,3), 4) + 1;
    k = k+2;
end

% sort by father nodes
orderedJunc = sortrows(junc, 3);


% plot unorrdered junctions = position of father
labels = cellstr( num2str(orderedJunc(:,4)) );  %' # labels correspond to their order [1:n]'
figure, imshow(Img)
% hold on;
% for i=1:length(S)
%     L=S{i};
%     plot(L(:,2),L(:,1),'-','Color','blue');
% end
hold on
plot(orderedJunc(:,2), orderedJunc(:,1), 'rx')
text(orderedJunc(:,2), orderedJunc(:,1), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right');
hold off

%% Segment smaller vessels
I = Img; % Input Image
PV = output3; % Principle vessel
% for i=2:n % 1 is root
    % caculate how to crop from a junction 
    % [xmin ymin width height]
    i = 5;
    xmin = orderedJunc(i,2);
    ymin = orderedJunc(i,1);
    w = abs(xmin-orderedJunc(orderedJunc(i,3),2));
    h =  abs(ymin-orderedJunc(orderedJunc(i,3),1));
    
    % images after cropping from I and PV
    position = [xmin ymin w h];
    croppedI = imcrop(I, position);
    figure, imshow(croppedI); title('croppedI');
    croppedPV = imcrop(PV, position);
    figure, imshow(croppedPV); title('croppedPV');
    
    % change the gray level at principle vessel by min of the image U
    % change k if the foreround and backround change
    % a = max(max(croppedI)); %??? k  
    a = 220;
    croppedI(find(croppedPV==1)) = a;
    figure, imshow(croppedI);
    save removePV2 croppedI
    
    % Segment image U to find smaller vessel
    % BW
    BW = croppedPV;
    
    % If find new vessels, add into PV and Coor
    % how to add?
    BW = BW | croppedPV;
    sz = size(BW);
    PV2 = PV;
    PV2(ymin:ymin+sz(1)-1, xmin:xmin+sz(2)-1) = BW;
    
%     figure, imshow(croppedPV);
%     figure, imshow(PV2);
%     hold on
%     plot(xmin, ymin, '*', 'color', 'r');
%     hold on
%     plot(xmin+sz(2)-1,  ymin+sz(1)-1, '*', 'color', 'b')
%     hold off
    
% end