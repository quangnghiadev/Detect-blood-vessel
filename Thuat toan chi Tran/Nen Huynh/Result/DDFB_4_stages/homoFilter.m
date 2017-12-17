function[Ihmf] = homoFilter(I)
%Ihmf_spatial
% I = imread('test.jpg');
% figure, imshow(I);

I = im2double(I);
I = log(1 + I);

M = 2*size(I,1) + 1;
N = 2*size(I,2) + 1;

sigma = 10;
[X, Y] = meshgrid(1:N,1:M);
centerX = ceil(N/2);
centerY = ceil(M/2);
gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
H = exp(-gaussianNumerator./(2*sigma.^2));
H = 1 - H;
% imshow(H,'InitialMagnification',25)

H = fftshift(H);

If = fft2(I, M, N);
Iout = real(ifft2(H.*If));
Iout = Iout(1:size(I,1),1:size(I,2));

Ihmf = exp(Iout) - 1;

% imshowpair(I, Ihmf, 'montage')

% alpha = 0.5;
% beta = 1.5;
% Hemphasis = alpha + beta*H;
% 
% % plot(1:30,H(1,1:30),'r',1:30,Hemphasis(1,1:30),'b','LineWidth',2);
% % grid on;
% % legend('High-pass Filter','High-frequency Emphasis Filter','Location','best');
% 
% If = fft2(I, M, N);
% Iout = real(ifft2(Hemphasis.*If));
% Iout = Iout(1:size(I,1),1:size(I,2));
% 
% Ihmf_2 = exp(Iout) - 1;
% 
% % figure, imshowpair(I, Ihmf_2, 'montage')
% % figure, imshowpair(Ihmf, Ihmf_2, 'montage')
% % figure, imshow(histeq(mat2gray(Ihmf)))
% % figure, imshowpair(histeq(mat2gray(Ihmf)), histeq(mat2gray(Ihmf_2)), 'montage')
% 
% paddedI = padarray(I,ceil(size(I)/2)+1,'replicate');
% paddedI = paddedI(1:end-1,1:end-1);
% 
% If = fft2(paddedI);
% Iout = real(ifft2(Hemphasis.*If));
% % figure, imshow(Iout)
% 
% Iout = Iout(ceil(M/2)-size(I,1)/2+1:ceil(M/2)+size(I,1)/2, ...
%             ceil(N/2)-size(I,2)/2+1:ceil(N/2)+size(I,2)/2);
% 
% Ihmf_3 = exp(Iout) - 1;
% % figure, imshowpair(Ihmf_2, Ihmf_3, 'montage');
% % figure, imshowpair(histeq(mat2gray(Ihmf_2)), histeq(mat2gray(Ihmf_3)), 'montage')
% 
% filterRadius = sigma;
% filterSize = 2*filterRadius + 1;
% hLowpass = fspecial('average', filterSize);
% hImpulse = zeros(filterSize);
% hImpulse(filterRadius+1,filterRadius+1) = 1;
% hHighpass = hImpulse - hLowpass;
% 
% Ihmf_spatial = imfilter(I, hHighpass, 'replicate');
% 
% Ihmf_spatial = exp(Ihmf_spatial) - 1;

% figure, imshowpair(I, Ihmf_spatial, 'montage');
% figure, imshow(Ihmf_spatial);
% title('Frequency - Spatial domain');
% figure, imshowpair(histeq(mat2gray(Ihmf_2)), histeq(mat2gray(Ihmf_spatial)), 'montage');

