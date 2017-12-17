function [PV, lines, juncs] = detectVessel_2(Img)
ratio = 0.02;
distance = 10;

% Taking main vessel
I1 = takingPV(Img);
% I1 =  run3_CoarseToFine(Img);
figure, imshow(I1); title('Coarse To Fine');

% Taking neighbors of main vessel
I2 = findNeighbors( I1, ratio, distance);
PV = im2double(1-I2);

% Set of vessels between junctions
% S : Cell array with the centerline coordinates of the skeleton branches
PV = PV<0.5;
Skel = skeleton(PV);
Skel = connectVessels(Skel, distance);
% load Skel

% Set of Junctions
newCoor = [];
for i=1:length(Skel)
    k = Skel{i};
    % taking the first and the last nodes
    fi = k(1,:);
    la = k(end, :);
    if (fi==la)
        continue;
    end
    newCoor = [newCoor; fi; la];
end

% find start
sumCoor = sum(newCoor,2);
[M, idx] = min(sumCoor);
start = idx; 

%% sort by level of junctions
[orderedJunc, orderedLines] = findFather(newCoor, start, Skel);

lines = orderedLines;
juncs = orderedJunc;

% Set of strainght line points
% Arranging in order of the node position???
% lines = segment_coor(S, I);

end