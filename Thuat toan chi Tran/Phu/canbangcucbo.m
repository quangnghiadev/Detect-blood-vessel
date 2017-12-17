function [newimg] = canbangcucbo(oldimg,a,b)
% function [newimg] = canbangcucbo(oldimg,a,b)
% oldimg: anh can xu li
% [a,b]: khoang xam can xu li.
% Trong do: 0 <= a < b <= 255 (a,b nguyen)
if(a<0||b<0||b<=a||a>255||b>255)
    newimg = [];
    fprintf('\nDau vao Nhap Khong Dung.\n');
    return;
end
if(floor(a)~=a||floor(b)~=b)
    newimg = [];
    fprintf('\nDau vao Nhap Khong Dung.\n');
    return;
end
sz = size(oldimg);
dai = b-a+1;
nk = zeros(1,dai);
for i=1:dai
    nk(i) = sum(sum(oldimg==a+i-1));
end
n = sum(nk);
pin = nk/n;
s = zeros(1,dai);
for i=1:dai
    for j=1:i
        s(i) = s(i) + pin(j);
    end
end
chuyen = zeros(1,dai);
for i=1:dai
    for j=a:b
        if(s(i)<=(j-a)/(b-a))
            if(abs(s(i)-(j-1-a)/(b-a))<abs(s(i)-(j-a)/(b-a)))
                chuyen(i) = j-1;
            else
                chuyen(i) = j;
            end
            break;
        end
    end
end
newimg = oldimg;
for i=1:sz(1)
    for j=1:sz(2)
        for k = a:b
            if(newimg(i,j)==k)
                newimg(i,j) = chuyen(k+1-a);
                break;
            end
        end
    end
end
end