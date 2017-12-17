function [lines] = arrangedLines(S, root, level, newCoor)
% take the first branch
temp = S;
n = length(temp);

for i=1:n
    if sum(ismember(temp{i},root,'rows'))>0
        lines{level} = temp{i};
        level = level+1;
    end
    % remove root in temp
    temp{i} = [];
    break
end

% take the next branch
[lines] = arrangedLines(S, root, level);

end