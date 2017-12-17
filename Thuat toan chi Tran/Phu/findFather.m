function [orderedJunc, orderedLines] = findFather(newCoor, st, S)
% clc; clear all; close all;
% 
% addpath('Phu');
% % 
% load newCoor
% load st
% load S

% st = start;
% S = Skel;

% newCoor = [0 1; 1 0; 2 3; 3 4; 2 3; 1 0; 0 1; 0 5];

disp('Start Point: ');
disp(newCoor(st,:));

% loai nhung diem trung nhau
[C, ia, ic] = unique(newCoor, 'rows', 'stable');

lev = 0;
% start = 3;

% khoi tao father and level cho start
start = ic(st);
level = -ones(size(C,1),1);
level(start) = lev;

father = -ones(size(C,1),1);
father(start) = 0;

lev = lev + 1;
Ric = ic;

orderedLines = [];
count = 0;

while (~isempty(start))
%     disp('start = ');
%     disp(start);
    count = count+length(start);
%     if (count==length(C))
%         break;
%     end
    
    % find next
    next = [];
    for i=1:length(start)
        pos = find(Ric==start(i));
        if (isempty(pos))
            continue;
        end
        
        Ric(pos) = -1;
        
        % find next
        temp = mod(pos,2);
        temp(temp==0) = -1;
        child = pos+temp;
        
        father(Ric(child)) = start(i);
        next = [next Ric(child)'];
        Ric(child) = -1;
        
        % add in orderedLines
        k = round(pos/2);
        orderedLines = [orderedLines S(k)];
    end
    
    % dangerous
    if (isempty(next) && ~isequal(Ric,-ones(size(Ric))))
        % find neighbor point
        p = C(start,:);
        A = repmat(p,size(Ric,1),1);
        
        B = sum((newCoor-A).^2,2);
        [err,vt] = sort(B);
        
        next = vt(2);
        father(next) = start;
    end
    
    level(next) = lev;
    
    lev = lev+1;
    start = next;
    
end

[orderedJunc, idx] = sortrows([C, father, level], 4);
% disp('ordered Junctions');
% disp(orderedJunc);

% chuyen father
father2 = zeros(size(father));
A = orderedJunc(:,3);
for i=2:length(father2)
    k = find(idx==A(i), 1);
    father2(i) = k;
end

% ordered Junctions
orderedJunc(:,3) = [];
orderedJunc = [orderedJunc father2];

% t = array2table(orderedJunc,'VariableNames',{'x','y','level','father'});
% disp(t);
end









