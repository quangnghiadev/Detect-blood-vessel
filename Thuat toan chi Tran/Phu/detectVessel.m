function [S] = detectVessel(Img)
ratio = 0.02;

% Frangi Filter
[output,~,~] = FrangiFilter(Img);
% figure,imshow(output); 

% Otsu Method
level = graythresh(output);
Img_Pro = im2bw(output,level);
% figure,imshow(Img_Pro);

% Main vessel
theshold = 0.02;
% epxilon = 0.001;
distance = 10;

output1 = output;
output1(output1 <= theshold) = 0;
output1(output1 > theshold) = 1;

% Taking neighbors of main vessel
output2 = findNeighbors( output1, ratio, distance);
PV = im2double(output2);

% Set of vessels between junctions
S = skeleton(PV);
S = connectVessels(S, distance);

% Plot skeleton of the vessel
imshow(Img);
hold on;
for i=1:length(S)
    L=S{i};
    plot(L(:,2),L(:,1),'-','Color','blue');
end

% Set of strainght line points
lines = segment_coor(S, output);

for i=1:length(lines)
    S = lines{i};
    % Start_End = startend_point(S);
    Start_End = startend(S);
    Seed = seedPoint(Start_End, S, Img_Pro);
%     Seed = seed_point(Start_End, S, output);
    
%     for k=1:size(Start_End,1)
%         plot(Start_End(k,2),Start_End(k,1),'*','Color','c');
%     end
%     plot(Seed(2),Seed(1),'*','Color','k');
    
    n = length(S);
    Coor = [];
    for k=1:n
         L = S{k};
         Coor = [Coor; L(1,:); L(end,:)];
    end
    % Set of juctions
    % Coor = sub_not_coor(Coor);
    
    % Detect the level of juctions
    % detect_level(Seed,Coor,1);
end

end















