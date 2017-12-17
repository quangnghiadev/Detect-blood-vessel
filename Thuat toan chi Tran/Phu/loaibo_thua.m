function Se = loaibo_thua(S)
Se = cell(1);
for i=1:length(S)
    LS = S{i};
    flag = 0;
    for j=1:length(Se)
        LSe = Se{j};
        if(equal_segment(LS,LSe))
            flag = 1;
            break;
        end
    end
    if(flag==0)
        id = 0;
        if(isempty(Se{1})~=1)
            id = length(Se);
        end
        Se{id+1} = LS;
    end
end
end