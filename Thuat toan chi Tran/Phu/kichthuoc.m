function result = kichthuoc(S)
n = length(S);
result = 0;
for i=1:n
    result = result + length(S{i});
end
end