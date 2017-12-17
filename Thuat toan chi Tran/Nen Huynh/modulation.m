function [g] = modulation(f)

%Multiplies image f by (1)^(x+y) to center spectrum of FT
%The output image g will be of class double
%IT IS ASSUMED THAT BOTH M AND N ARE EVEN
%plan to use it with Fourier transform, which already assumes that

	[m,n]=size(f);
	
%sequence of alternating 1's and -1's of length m
	s(1:m)=1;
	s(2:2:m)=-1;
%make a column vector out of this
	c=s';

%sequence of alternating 1's and -1's of length n
	r(1:n)=1;
	r(2:2:n)=1;

%the matrix product of c*r gives a matrix of size mxn with alternating 1's and -1's	
		
	%matrix=c*r;

matrix=ones(m,n);
matrix(:,2:2:m)=-1*matrix(:,2:2:m);
	%f=im2double(f);

	g=f.*matrix;

% End of function 





  