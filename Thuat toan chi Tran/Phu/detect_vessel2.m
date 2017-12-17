function [PV, lines, Coor] = detect_vessel2(Img,ratio)

% Imgt = tesst(Img);
% ImP = hight_pass(Img);
% figure,imshow(ImP); 
[output,~,~] = FrangiFilter(Img);
% figure,imshow(output); 

level = graythresh(output);
Img_Pro = im2bw(output,level);
% figure,imshow(Img_Pro);

theshold = 0.02;
epxilon = 0.001;
ep_kc = 10;
% a = output(output~=0);
% b = a(a<mean(a));
% theshold = mean([mean(a), mean(b)]);

% output1 = output;
% output1(output1<=theshold) = 0;
% output1(output1>theshold) = 1;
% [output2, ~] = filter_neibor(output1,ratio,ep_kc);
[output, radius] = Filter_Otsu(output, ratio, theshold, epxilon);
[output,~] = filter_neibor(output,ratio,2*radius);
output2 = increa_diameter(output, 2*radius);

% figure,imshow(output);
% figure,imshow(output2);


output3 = im2double(output2);
S=skeleton(output3);
S = connect_vessel(S, ep_kc);
S = connect_vessel(S, 2*radius);

imshow(Img);
hold on;
for i=1:length(S)
    L=S{i};
    plot(L(:,2),L(:,1),'-','Color','blue');
%      plot(L(1,2),L(1,1),'*','Color','red');
%      plot(L(end,2),L(end,1),'*','Color','red');
end

Se = segment_coor(S, output);

for i=1:length(Se)
    S = Se{i};
    % Start_End = startend_point(S);
    Start_End = startend(S);
    Seed = seed_point(Start_End, S, Img_Pro);
%     Seed = seed_point(Start_End, S, output);
    
    % for i=1:size(Start_End,1)
    %     plot(Start_End(i,2),Start_End(i,1),'*','Color','c');
    % end
    % plot(Seed(2),Seed(1),'*','Color','k');
    
    n = length(S);
    Coor = [];
    for i=1:n
         L = S{i};
         Coor = [Coor; L(1,:); L(end,:)];
    end
    Coor = sub_not_coor(Coor);
    detect_level(Seed,Coor,1);
end

end