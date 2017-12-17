function[J] = highPassFilter(I)
%K = 1/9*[-1 -1 -1; -1 8 -1; -1 -1 -1];
K = [0 -1/4 0; -1/4 2 -1/4; 0 -1/4 0];

J = imfilter(I, K);
end