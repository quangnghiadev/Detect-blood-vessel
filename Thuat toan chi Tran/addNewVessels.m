function [] = addNewVessels(I, PV, lines, juncs)

% Segment smaller vessels
% I = Img; % Input Image
% PV = output3; % Principle vessel
N = length(juncs);
for i=3:N % 1 is root
    % caculate how to crop from a junction 
    % [xmin ymin width height]
    xmin = juncs(i,2);
    ymin = juncs(i,1);
    xfa = juncs(i-1,2);
    yfa = juncs(i-1,1);
    w = abs(xmin-xfa);
    h =  abs(ymin-yfa);
    
    % images after cropping from I and PV
    e = 10; % e = expand
    % position = [xmin ymin w h];
    newPosition = [xfa-e yfa-e w+2*e h+2*e];
    newPosition(newPosition<0) = 0;
    croppedI = imcrop(I, newPosition);
    
    figure, imshow(I);
    hold on
    plot(xfa-e,yfa-e,'*');
    hold on
    plot(xmin,ymin,'*');
    hold off
    
    figure, imshow(croppedI); title('croppedI');
    
    croppedPV = imcrop(PV, newPosition);
    figure, imshow(croppedPV); title('croppedPV');
    
    % change the gray level at principle vessel by min of the image U
    % change k if the foreround and backround change
    % a = max(max(croppedI)); %??? k  
    % a = 220;
    a = median(median(croppedI));
    croppedI(find(croppedPV==1)) = a;
    figure, imshow(croppedI); title('removePV');
    save removePV croppedI
    
    % Continue segmenting image 'croppedI' to find smaller vessel
    % BW = ???
    % BW = segmentSVessels(croppedI);
    BW = croppedPV;
    
    % If find new vessels, add into PV and Coor
    % how to add?
    BW = BW | croppedPV;
    sz = size(BW);
    PV2 = PV;
    x = newPosition(1);
    y = newPosition(2);
    PV2(y:y+sz(1)-1, x:x+sz(2)-1) = BW;
    
%     figure, imshow(croppedPV);
%     figure, imshow(PV2);
%     hold on
%     plot(x, y, '*', 'color', 'r');
%     hold on
%     plot(x+sz(2)-1,  y+sz(1)-1, '*', 'color', 'b')
%     hold off
    
end
% end