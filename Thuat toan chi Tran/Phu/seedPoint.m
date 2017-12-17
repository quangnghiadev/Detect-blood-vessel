function [Seed] = seedPoint(Start_End, S, Img)
sz_S_E = size(Start_End);   
radius_max = 0; Seed = [];
n = length(S); Coor = [];
for i=1:n
    L = S{i};
    Coor = [Coor; L(1,:); L(end,:)];
end
for i=1:sz_S_E(1)
    P = Start_End(i,:);
    id = find_point(Coor, P);
    L = S{id};
    sz_L = size(L,1);
    imid = ceil(sz_L/2);
    imid_next = imid+1;
    if(imid_next>sz_L)
        imid_next = imid;
    end
    point = L(imid,:);
    p0 = L(imid_next,:);
  
    point1 = P;
    p1 = point;
    if(sum(sum(L(1,:)==P))==2&&sz_L>=2)
        p1 = L(2,:);
    end
    if(sum(sum(L(end,:)==P))==2&&sz_L>=2)
        p1 = L(end-1,:);
    end
    vector = p0-point;
    radius = estimate_radius(point,vector,Img);
    vector1 = p1-point1;
    radius1 = estimate_radius(point1,vector1,Img);
    radius = max(radius,radius1);
    if(radius>radius_max)
        radius_max = radius;
        Seed = P;
    end
end
end




