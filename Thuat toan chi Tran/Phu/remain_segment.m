function SR = remain_segment(S, Se)
SR = cell(1); r = 1;
Stem = cell(1); tem = 1;
for i=1:length(Se)
    ST = Se{i};
    for j=1:length(ST)
        Stem{tem} = ST{j};
        tem = tem+1;
    end 
end
for i=1:length(S)
    flag = 0;
    for j=1:length(Stem)
        if(equal_segment(S{i},Stem{j}))
            flag = 1;
            break;
        end
    end
    if(flag==0)
        SR{r} = S{i};
        r = r+1;
    end
end
end