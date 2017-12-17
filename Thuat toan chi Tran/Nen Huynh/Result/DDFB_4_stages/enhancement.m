function [J] = enhancement(I,k)
%I is a directional image.

%find average theta 
switch k
    case 1
        theta = (pi/4 + 3*pi/8)/2;
    case 2
        theta = (3*pi/8 + pi/2)/2;
    case 3
        theta = (pi/2 + 5*pi/8)/2;
    case 4
        theta = (5*pi/8 + 3*pi/4)/2;
    case 5
        theta = (3*pi/4 + 7*pi/8)/2;
    case 6
        theta = (7*pi/8 + pi)/2;
    case 7
        theta = (pi/8)/2;
    otherwise
        theta = (pi/8 + pi/4)/2;
end

%I(x',y')
x = I(:,1);
y = I(:,2);
x1 = x*cos(theta) + y*sin(theta);
y1 = x*sin(theta) + y*cos(theta);
lamda = 1;
S = [1 sqrt(2) 2 2*sqrt(2) 4];

C = 1;
h11 = 0;
h22 = ()*vessel(y1,C);


h11 = 0;
h


end