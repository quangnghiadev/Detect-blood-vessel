function kk=four_r(x,choice)
%clc;
c=x;

a= size(x);

if (mod(a(1),2)==0)
            center1=(a(1)/2)+1;
            a(1)=a(1)+1;
            b=zeros(a(1),a(2));
            b(1:a(1)-1,1:a(2))=x;
            x=b;
    else
    
            center1=(a(1)+1)/2;
    
end
if (mod(a(2),2)==0)
            center2=(a(2)/2)+1;
            a(2)=a(2)+1;
            b=zeros(a(1),a(2));
            b(1:a(1),1:a(2)-1)=x;
            x=b;
    else
    
            center2=(a(2)+1)/2;
    
end


lac=zeros(a(1),a(2));
switch choice
    case 1
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 0; 1 1]*[1 1;-1 1]*[1 0;-1 1]));
     case 2
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 0; 1 1]*[1 1;-1 1]*[1 0;1 1]));
     case 3
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 0; -1 1]*[1 1;-1 1]*[1 1;0 1]));
    case 4
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 0; -1 1]*[1 1;-1 1]*[1 -1;0 1]));
     case 5
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 -1; 0 1]*[1 1;-1 1]*[1 -1;0 1]));
    case 6
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 -1; 0 1]*[1 1;-1 1]*[1 1;0 1]));
    case 7
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 1; 0 1]*[1 1;-1 1]*[1 0;1 1]));
     case 8
    q1=(inv([1 1;-1 1]*[1 1;-1 1]*[1 1; 0 1]*[1 1;-1 1]*[1 0;-1 1]));
end
for i=1: a(1)
    for j= 1:a(2)
     gen=zeros(1,2);
     gen(1)=center1-i;
     gen(2)=j-center2;
     mul=zeros(1,2);
     mul=(q1*gen')';
     if ((mul(1)>=(-center1+1)) & (mul(1)<=(center1-1)) & (mul(2)>=(-center2+1)) & (mul(2)<=(center2-1)))
         
             or=center1-mul(1);
                  
  
              oc=mul(2)+center2;
       if ((or-floor(or))==0) & ((oc-floor(oc))==0) 
         lac(center1-gen(1),gen(2)+center2)=x(or,oc);
     end
 end
end
end
d=size(c);
if (mod(d(1),2)==0)&(mod(d(2),2)==0)
    kk=lac(1:a(1)-1,1:a(2)-1);
else
kk=lac;
end
end