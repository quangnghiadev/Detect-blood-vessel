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
    disp(newCoor);
end