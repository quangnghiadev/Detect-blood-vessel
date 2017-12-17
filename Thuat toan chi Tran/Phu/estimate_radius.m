function [radius] = estimate_radius(point,vector,Img)
pt = [vector(2), -vector(1)];
dl = max(abs(pt));
pt = pt/dl;
radius = 0; alpha = 0; alpha_max = 15;
 x01 = round(point(1)); y01 = round(point(2));
 x02 = round(point(1)); y02 = round(point(2));
while(Img(x01,y01)~=0&&Img(x02,y02)~=0&&alpha<alpha_max)
    alpha = alpha+1;
    xy1 = round(alpha*pt + point);
    x01 = xy1(1); y01 = xy1(2);
    xy2 = round(-alpha*pt + point);
    x02 = xy2(1); y02 = xy2(2);
    if(x01<=0||x02<=0||y01<=0||y02<=0||x01>size(Img,1)||x02>size(Img,1)||y01>size(Img,2)||y02>size(Img,2))
        break;
    end
end
radius = sqrt(sum((alpha*pt).^2));
end