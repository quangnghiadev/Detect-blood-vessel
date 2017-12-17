function [smallVessels] = addNewVessels_2(I, PV, juncs)

% Segment smaller vessels
% I = Img; % Input Image
% PV = output3; % Principle vessel
N = length(juncs);
smallVessels = PV;

for i=14:N % 1 is root
    % caculate how to crop from a junction 
    % [xmin ymin width height]
    x = juncs(i,2);
    y = juncs(i,1);
    f = juncs(i,4); % col 4 is father
    xfa = juncs(f,2);
    yfa = juncs(f,1);
    
    xmin = min(x,xfa); ymin = min(y,yfa);
    w = abs(x-xfa);
    h =  abs(y-yfa);
    
    % images after cropping from I and PV
    e = 20; % e = expand
    newPosition = [xmin-e ymin-e w+2*e h+2*e];
    newPosition(newPosition<1) = 1;
    newPosition = round( newPosition);
    croppedI = imcrop(I, newPosition);
    
    figure, imshow(I);
    hold on
    plot([xfa x],[yfa y],'*');
    hold on
    line([xfa x],[yfa y],'Color','red','LineStyle','-');
    hold on
    rectangle('Position', newPosition, 'EdgeColor','b', 'LineWidth',2);
    hold off
    
    
    croppedPV = imcrop(PV, newPosition);
    
    % Continue segmenting image 'croppedI' to find smaller vessel
    % BW = segmentSVessels(croppedI);
    % Remove PV in cropped I? NoOOOOOOOO
%     med = median(median(croppedI));
%     croppedI(find(croppedPV==1)) = med;
    % Processing
%     %High-Pass Filter
%     croppedI = highPassFilter(croppedI);
% 
%     %Frangi Filter 
%     Ivessel = FrangiFilter2D(croppedI);
% 
%     %Median Filter
%     J = medfilt2(Ivessel);
%     figure, imshow(J);

    BW = takingPV(croppedI);
    figure, imshow(BW, []); title('BW');
    BW2 = bwareaopen(BW,10);
    
    % choosing small vessels
    mainAngle = atan(-(yfa-y)/ (xfa-x))*180/pi;
    % xfa = x?
    if (mainAngle<0)
        mainAngle = mainAngle+180;
    end
    BW3 = chooseOrientation(BW2, mainAngle);
    
    % If find new vessels, add into PV and Coor
    % how to add?
    BW4 = BW3 | croppedPV;
    
    % adding BW2 into PV
    sz = size(BW4);
    PV2 = PV;
    x = newPosition(1);
    y = newPosition(2);
    PV2(y:y+sz(1)-1, x:x+sz(2)-1) = BW4;
%     figure, imshow(PV2); title('PV2');

    smallVessels = smallVessels | PV2;
    figure,
    subplot(1,3,1); imshow(croppedI); title('croppedI');
    subplot(1,3,2); imshow(croppedPV); title('croppedPV');
    subplot(1,3,3); imshow(BW4); title('taking smaller vessels'); 
    close all; 
end

figure, imshow(smallVessels); title('Small Vessels'); 
end