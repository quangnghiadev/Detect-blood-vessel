function result = DDFB(I,N,order)
% name: ddfb_4_stages
% I is input image
% N is the branch or stage number i.e. 1-4
% N means 2^N: the number of directional images
% order is the size of one-dimensional low pass filter
% order is the size of directional filters

switch N
    case 1
        f_filter1 =hour_low(order);
        f_filter2=hour_high(order);
        f1=imfilter(I,f_filter1,'circular','same');
        f2=imfilter(I,f_filter2,'circular','same');
        clear('f_filter1','f_filter2');
%         result = cell(1,2);
%         result{1} = f1;
%         result{2} = f2;
        result = zeros(size(I,1),size(I,2),2*N);
        result(:,:,1) = f1;
        result(:,:,2) = f2;
    case 2
        f_filter1 =hour_low(order);
        f_filter2=hour_high(order);
        f1=imfilter(I,f_filter1,'circular','same');
        f2=imfilter(I,f_filter2,'circular','same');
        %clear f_fil*;
        
        s_filter1=synquin1(f_filter1);
        s_filter2=synquin1(f_filter2);
        s1=imfilter(f1,s_filter1,'circular','same');
        s2=imfilter(f1,s_filter2,'circular','same');
        s3=imfilter(f2,s_filter1,'circular','same');
        s4=imfilter(f2,s_filter2,'circular','same');
        clear f*; clear s_fil*;
%         result = cell(1,4);
        result = zeros(size(I,1),size(I,2),2*N);
        for i=1:4
            s=eval(strcat('s',num2str(i)));
%             result(i) = s;
            result(:,:,i) = s;
        end
    case 3
        f_filter1 =hour_low(order);
        f_filter2=hour_high(order);
        f1=imfilter(I,f_filter1,'circular','same');
        f2=imfilter(I,f_filter2,'circular','same');
        
        s_filter1=synquin1(f_filter1);
        s_filter2=synquin1(f_filter2);
        j=0;
        k=1;
        for i=1:8
            j=j+1;
            eval(['t_filter' num2str(i) '= third_r(f_filter' num2str(j) ',' num2str(k) ');']);
            if j==2
               j=0;
               k=k+1;
            end
        end
      
        clear f_fil*;
        
        s1=imfilter(f1,s_filter1,'circular','same');
        s2=imfilter(f1,s_filter2,'circular','same');
        s3=imfilter(f2,s_filter1,'circular','same');
        s4=imfilter(f2,s_filter2,'circular','same');
        clear f*; clear s_fil*;
        
%         t1=imfilter(s2,t_filter1,'circular','same');
%         t2=imfilter(s2,t_filter2,'circular','same');
%         t3=imfilter(s1,t_filter4,'circular','same');
%         t4=imfilter(s1,t_filter3,'circular','same');
%         t5=imfilter(s3,t_filter6,'circular','same');
%         t6=imfilter(s3,t_filter5,'circular','same');
%         t7=imfilter(s4,t_filter7,'circular','same');
%         t8=imfilter(s4,t_filter8,'circular','same');
        
        t3=imfilter(s2,t_filter1,'circular','same');%t3
        t4=imfilter(s2,t_filter2,'circular','same');%
        t5=imfilter(s1,t_filter4,'circular','same');
        t6=imfilter(s1,t_filter3,'circular','same');
        t7=imfilter(s3,t_filter6,'circular','same');
        t8=imfilter(s3,t_filter5,'circular','same');
        t1=imfilter(s4,t_filter7,'circular','same');
        t2=imfilter(s4,t_filter8,'circular','same');
        clear s*; clear t_fil*;
%         result = cell(1,8);
        result = zeros(size(I,1),size(I,2),2*N);
        for i=1:8
            t=eval(strcat('t',num2str(i)));
%             result{i} = t;
            result(:,:,i) = t;
        end
    case 4
        f_filter1 =hour_low(order);
        f_filter2=hour_high(order);
        f1=imfilter(I,f_filter1,'circular','same');
        f2=imfilter(I,f_filter2,'circular','same');
        
        s_filter1=synquin1(f_filter1);
        s_filter2=synquin1(f_filter2);
        j=0;
        k=1;
        for i=1:8
            j=j+1;
            eval(['t_filter' num2str(i) '= third_r(f_filter' num2str(j) ',' num2str(k) ');']);
            if j==2
               j=0;
               k=k+1;
            end
        end
        
        j=0;
        k=1;
        for i=1:16
            j=j+1;
            eval(['fourth_filter' num2str(i) '= four_r(f_filter' num2str(j) ',' num2str(k) ');']);
            if j==2
               j=0;
               k=k+1;
            end
        end
      
        clear f_fil*;
        
        s1=imfilter(f1,s_filter1,'circular','same');
        s2=imfilter(f1,s_filter2,'circular','same');
        s3=imfilter(f2,s_filter1,'circular','same');
        s4=imfilter(f2,s_filter2,'circular','same');
        clear f1; clear f2; clear s_fil*;
        
        t1=imfilter(s2,t_filter3,'circular','same');
        t2=imfilter(s2,t_filter4,'circular','same');
        t3=imfilter(s1,t_filter2,'circular','same');
        t4=imfilter(s1,t_filter1,'circular','same');
        t5=imfilter(s3,t_filter6,'circular','same');
        t6=imfilter(s3,t_filter5,'circular','same');
        t7=imfilter(s4,t_filter7,'circular','same');
        t8=imfilter(s4,t_filter8,'circular','same');
        clear s*; clear t_fil*;
        
        four5=imfilter(t3,fourth_filter1,'circular','same');
        four6=imfilter(t3,fourth_filter2,'circular','same');
        four8=imfilter(t4,fourth_filter3,'circular','same');
        four7=imfilter(t4,fourth_filter4,'circular','same');
        four2=imfilter(t1,fourth_filter5,'circular','same');
        four1=imfilter(t1,fourth_filter6,'circular','same');
        four3=imfilter(t2,fourth_filter7,'circular','same');
        four4=imfilter(t2,fourth_filter8,'circular','same');
        four15=imfilter(t8,fourth_filter9,'circular','same');
        four16=imfilter(t8,fourth_filter10,'circular','same');
        four14=imfilter(t7,fourth_filter11,'circular','same');
        four13=imfilter(t7,fourth_filter12,'circular','same');
        four12=imfilter(t6,fourth_filter13,'circular','same');
        four11=imfilter(t6,fourth_filter14,'circular','same');
        four9=imfilter(t5,fourth_filter15,'circular','same');
        four10=imfilter(t5,fourth_filter16,'circular','same');
        clear t*; clear fourth_fil*; 
%         result = cell(1,16);
            result = zeros(size(I,1),size(I,2),2*N);
        for i=1:16
            f=eval(strcat('four',num2str(i)));
%             result{i} = f;
            result(:,:,i) = f;
%             figure, imshow(result{1});
%             figure, imshow(result(:,:,i),[]);
        end
        
end
