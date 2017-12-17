function Start_End = startend_point(S)
    epxilon = 0;
    n = length(S);
    Coor = []; Start_End = [];
    for i=1:n
        L = S{i};
        Coor = [Coor; L(1,:); L(end,:)];
    end
    for i=1:n
        L = S{i};
        Temp = L(1,:);
        F1 = find(Coor(:,1)>=Temp(1)-epxilon&Coor(:,1)<=Temp(1)+epxilon);
        if(length(F1)>0)
            ST = [];
            for j=1:length(F1)
               ST = [ST; Coor(F1(j),2)]; 
            end
            F2 = find(ST>=Temp(2)-epxilon&ST<=Temp(2)+epxilon);
            if(length(F2)==1)
                Start_End = [Start_End; Temp];
            end
        end
        Temp = L(end,:);
        F1 = find(Coor(:,1)>=Temp(1)-epxilon&Coor(:,1)<=Temp(1)+epxilon);
        if(length(F1)>0)
            ST = [];
            for j=1:length(F1)
               ST = [ST; Coor(F1(j),2)]; 
            end
            F2 = find(ST>=Temp(2)-epxilon&ST<=Temp(2)+epxilon);
            if(length(F2)==1)
                Start_End = [Start_End; Temp];
            end
        end
    end
end