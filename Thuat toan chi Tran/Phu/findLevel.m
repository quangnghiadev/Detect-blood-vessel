function [orderedJunc, orderedLines] = findLevel(newCoor, st, S)

% A = [0 1; 1 0; 2 3; 3 4; 2 3; 1 0; 0 1; 0 5]; 

disp('Start Point: ');
disp(newCoor(st,:));

% removing the duplicated junctions
[C, ia, ic] = unique(newCoor, 'rows', 'stable');

level = 0;
n = length(newCoor);
start = ic(st); %chinh lai vi tri cua start trong C

father = -ones(size(C,1),1);
father(start) = level;

level = level+1;
m = n;
Ric = ic;

orderedLines = [];

while m>0
    % Tim doan thang cua start trong S
    
    next = [];
    for i=1:length(start)
        p = find(Ric == start(i));
        pos = p;
        % kiem tra p da xet chua
        for j1=1:length(p)
            if Ric(p(j1))==-1
                pos(j1) = [];
            end
        end
        % Xoa vi tri pos trong Ric
        Ric(pos) = -1;
        
        % add in orderedLines
        k = round(pos/2);
        orderedLines = [orderedLines S(k)];
        
        % Lay phan tu trong moi cap cua pos de xet lam start
        for j=1:length(pos)
            if mod(pos(j),2)==0
                next = [next ic(pos(j)-1)];
                Ric(pos(j)-1) = -1;
            else
                next = [next ic(pos(j)+1)];
                Ric(pos(j)+1) = -1;
            end
        end
    end
    
    % check next
    % kiem tra cha cua next
    father(next) = level;
    start = next;
    
    level = level+1;
    k = length(start);
    m = m-2*k; % if m find a new child 
    disp('m = '); disp(m);
    
    disp('Father of junctions: ');
    disp([C father]);
end

father = [C father];

% sort by level of nodes
[orderedJunc] = sortrows(father, 3);

end