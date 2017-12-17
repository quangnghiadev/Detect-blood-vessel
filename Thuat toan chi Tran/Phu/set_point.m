function H = set_point(S,id)
H = [];
for i=1:size(S,2)
    if(i~=id)
        H = [H; S{i}];
    end
end
end