function Se = getsegment(S, Stem, Coor, Seed, vecto)
%     figure;
%     hold on;
%     if(isempty(Stem{1})~=1)
%     for i=1:length(Stem)
%         L=Stem{i};
%         plot(L(:,2),L(:,1),'-','Color','blue');
%         plot(L(1,2),L(1,1),'*','Color','red');
%         plot(L(end,2),L(end,1),'*','Color','red');
%     end
%     end
    Se = Stem; vecto = vecto/max(abs(vecto));
    id_seed = finds_point(Coor, Seed);
    
    % End Point
    if(isempty(id_seed))
        return;
    end
    
    % 1 or 2 branch.
    if(length(id_seed)<=2)
        for i=1:length(id_seed)
            cs = 0;
            if(isempty(Se{1})~=1)
                cs = length(Se);
            end
            id = id_seed(i);
            Se{cs+1} = S{id};
            ST = S{id};
            L = Coor(2*id-1:2*id,:);
            vect = [0 0];
            if(L(1,1)==Seed(1)&&L(1,2)==Seed(2))
                Next_Seed = L(2,:);
                vect = Next_Seed - ST(min(max(1,end-5),max(1,end-10)),:);
                vect = vect/max(abs(vect));
            else
                Next_Seed = L(1,:);
                vect = Next_Seed - ST(max(min(10,end),min(5,end)),:);
                vect = vect/max(abs(vect));
            end
            L = [0 0; 0 0];
            Coo = [Coor(1:2*id-2,:); L; Coor(2*id+1:end,:)];
            Se = getsegment(S, Se, Coo, Next_Seed, vect);
        end
    end
    
    % over 2 branch.
    if(length(id_seed)>2)
        id_next = 1:length(id_seed);
        id_sub = [];
        v = zeros(length(id_seed),2);
        angle = zeros(1,length(id_seed));
        for i=1:length(id_seed)
            id = id_seed(i);
            ST = S{id};
            L = Coor(2*id-1:2*id,:);
            if(L(1,1)==Seed(1)&&L(1,2)==Seed(2))
                v(i,:) = ST(max(min(10,end),min(5,end)),:)-Seed;
                v(i,:) = v(i,:)/max(abs(v(i,:)));
            else
                v(i,:) = ST(min(max(1,end-5),max(1,end-10)),:)-Seed;
                v(i,:) = v(i,:)/max(abs(v(i,:)));
            end
            angle(i) = real(angle_vecto(v(i,:), vecto));
            if(angle(i)>90)
                id_sub = [id_sub i];
                i_n = find(id_next==i);
                if(isempty(i_n)~=1)
                    id_next = [id_next(1:i_n-1), id_next(i_n+1:end)];
                end
            end
        end
        id_next_tem = id_next;
        id_sub_tem = id_sub;
        for i=1:length(id_sub_tem)
            for j=1:length(id_next_tem)
                angle_t = real(angle_vecto(v(id_sub_tem(i),:),-v(id_next_tem(j),:)));
                if(angle_t<angle(id_next_tem(j)))
                    i_n = find(id_next==id_next_tem(j));
                    if(isempty(i_n)~=1)
                        id_sub = [id_sub id_next(i_n)];
                        id_next = [id_next(1:i_n-1), id_next(i_n+1:end)];
                    end
                end
            end
        end
        id_next = id_seed(id_next);
        id_sub = id_seed(id_sub);
        Coor2 = Coor;
        for i=1:length(id_sub)
            id = id_sub(i);
            L = [0 0; 0 0];
            Coor2 = [Coor2(1:2*id-2,:); L; Coor2(2*id+1:end,:)];
        end
        
        for i=1:length(id_next)
            cs = 0;
            if(isempty(Se{1})~=1)
                cs = length(Se);
            end
            id = id_next(i);
            Se{cs+1} = S{id};
            L = Coor(2*id-1:2*id,:);
            vect = [0 0];
            if(L(1,1)==Seed(1)&&L(1,2)==Seed(2))
                Next_Seed = L(2,:);
                vect = Next_Seed - ST(min(max(1,end-5),max(1,end-10)),:);
                vect = vect/max(abs(vect));
            else
                Next_Seed = L(1,:);
                vect = Next_Seed - ST(max(min(10,end),min(5,end)),:);
                vect = vect/max(abs(vect));
            end
            L = [0 0; 0 0];
            Coo = [Coor2(1:2*id-2,:); L; Coor2(2*id+1:end,:)];
            Se = getsegment(S, Se, Coo, Next_Seed, vect);
        end
        
    end
end




