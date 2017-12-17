function I = tesst(Img)
I = Img;
minI = min(I(:));
S = [I(1,1), I(1,end), I(end,1), I(end,end)];
F = find(S==minI);
if(length(F)<2)
    return;
end

epxilon = 15;
line = 1;
sz = size(I);
while(line<=sz(1))
    colum = ceil((1+sz(2))/2);
    while(colum>=1)
        if(abs(I(line,colum)-minI)<=epxilon)
            B = I(max(1,line-3):min(sz(1),line+3),max(1,colum-3):min(sz(2),colum+3));
            m1 = I(line,colum) - epxilon;
            m2 = I(line,colum) + epxilon;
            B = B(B>m2|B<m1);
            if(isempty(B))
                mu = 255;
            else
                mu = ceil(mean(B(:)));
            end
            I(line,colum) = mu;
        end
        colum = colum-1;
    end
    colum = ceil((1+sz(2))/2);
    while(colum<=sz(2))
        if(abs(I(line,colum)-minI)<=epxilon)
            B = I(max(1,line-3):min(sz(1),line+3),max(1,colum-3):min(sz(2),colum+3));
            m1 = I(line,colum) - epxilon;
            m2 = I(line,colum) + epxilon;
            B = B(B>m2|B<m1);
            if(isempty(B))
                mu = 255;
            else
                mu = ceil(mean(B(:)));
            end
            I(line,colum) = mu;
        end
        colum = colum+1;
    end
    line = line+1;
end
end