function result = equal_segment(S1,S2)
n1 = length(S1); n2 = length(S2);
result = 0;
if(n1==n2)
    mid = ceil((1+n1)/2);
    if(sum(S1(mid,:)==S2(mid,:))==2)
        if(sum(S1(1,:)==S2(1,:))==2&&sum(S1(end,:)==S2(end,:))==2)
            result = 1; return;
        end
        if(sum(S1(1,:)==S2(end,:))==2&&sum(S1(end,:)==S2(1,:))==2)
            result = 1; return;
        end
    end
end
end