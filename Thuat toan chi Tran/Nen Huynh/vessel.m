function I = vessel(y,C)
%this is the structure of a vessel
% a vessel is modeled as a tube with  Gaussian profile across its axis

% a is xichma_0^2
a = 1;
% C = 1;
% x = linspace(-2*pi,2*pi);
% y = linspace(-2*pi,2*pi);
I =(C*exp(-y.^2/2*a.^2))/2*pi*a.^2;
% plot3(x,y,I);
end