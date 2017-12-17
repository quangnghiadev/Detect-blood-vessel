function Direction = normal(Direction)
    [m n]=size(Direction);
    for i=1:m
        for j=1:n
            if (Direction(i,j)<0)
                Direction(i,j)=Direction(i,j)+pi;
            end
        end
    end
    Direction=pi-Direction;
end