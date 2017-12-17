clc; clear all; close all;

% First, image = 'vessels.jpg'
% After that, 'test2.jpg'

addpath('Data2')
addpath('Images')
addpath('Phu')
addpath('NSCT');
addpath('Nen Huynh');
addpath('test2_2');
addpath('NSCT\Original');

OriginLink = cd;

PrincipleVessel = {};
SmallerVessel = {};

% Run all database using file run3_CoarseToFine.m
accuracy = [];

for ii = 130:130
    %read file
    filename = ['Data2\a\'...
        'IM-0001-000' num2str(ii,'%03d') '.jpg'];
    I = imread(filename);
    if length(size(I))==3
        I = rgb2gray(I);
    end
    I = im2double(I);
    pos = [117.5 60.5 292 345];
    I = imcrop(I, pos);
    figure, imshow(I); title('I');
    
    % Process: Take PV
    [PV2, lines2, Coor2] = detectVessel_2(I);
    PrincipleVessel = [PrincipleVessel, {PV2}];
    save PrincipleVessel PrincipleVessel
    
    % Plot skeleton of the vessel
    %' # labels correspond to their order [1:n]'
    labels = cellstr( num2str(Coor2(:,3)) );
    figure, imshow(I); title('Skeleton and level of junctions');
    hold on;
    for i=1:length(lines2)
        k = lines2{i};
        plot(k(:,2),k(:,1),'-','Color','blue');
    end
    hold on
    plot(Coor2(:,2), Coor2(:,1), 'rx')
    text(Coor2(:,2), Coor2(:,1), labels, 'VerticalAlignment','bottom', ...
        'HorizontalAlignment','right');
    hold off
    
    % Process 2: Take small vessel
    smallVessels = addNewVessels_2(I, PV2, Coor2);
    SmallerVessel = [SmallerVessel, {smallVessels}];
    
    % Display
    figure,
    subplot(1,3,1); imshow(I); title('Input');
    subplot(1,3,2); imshow(PV2); title('Principle Vessel');
    subplot(1,3,3); imshow(smallVessels); title('Small Vessels');
    
    % Save file
    OutputFolder = 'Data2\a\Result\';
    cd(OutputFolder);
    filename = strcat(num2str(ii), '.mat'); % concentrate string
%     imwrite(smallVessels, [OutputFolder filename], 'jpg'); % the name of the image is 130.jpg and so on
    save(filename,'smallVessels');
    cd(OriginLink);
    
    % Calculate accuracy
    filename2 = ['Data2\a\'...
    'Ground Truth 130-136\IM-0001-000', num2str(ii), '.tif'];
    truth_img = imread(strcat(filename2));
    truth_img = imcrop(truth_img, pos);
    
    Dice = DicePercentMeasurement( truth_img, smallVessels );
    disp('Dice = ');
    disp(Dice);
    
    accuracy = [accuracy Dice];
    save accuracy
end
