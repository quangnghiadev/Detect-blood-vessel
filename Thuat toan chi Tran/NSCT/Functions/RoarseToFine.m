function[B] = RoarseToFine(A)
 % Convert to unit8
    I = A*255/max(max(A));
    
    % Display in 3D and use this image for next step
    res = grs2rgb(I,colormap);
%     figure, imshow(res,[]);
    
    % Using Otsu method 2 times, 3 times, 4 times
    ImgOtsu = cell(1,3);
    for i=1:3
        ImgOtsu{i} = otsu(res,i+1);
    end
    
%     figure,
%     subplot(1,2,1); imshow(I,[]); title('Original image');
%     subplot(1,2,2); imshow(ImgOtsu{3},[]); title('Otsu 4 times');
    
    % Convert to binary images
    OutputOtsu = ImgOtsu;
    
    OutputOtsu{1}(OutputOtsu{1}<2) = 0;
    OutputOtsu{1}(OutputOtsu{1}~=0) = 1;
    OutputOtsu{2}(OutputOtsu{2}<2) = 0;
    OutputOtsu{2}(OutputOtsu{2}~=0) = 1;
    OutputOtsu{3}(OutputOtsu{3}<3) = 0;%3
    OutputOtsu{3}(OutputOtsu{3}~=0) = 1;
    
    % Imshow recombination of Otsu n times iamges
    B = (OutputOtsu{1} | OutputOtsu{2}) | OutputOtsu{3};
%     A = imfill(A,'holes');
%     figure, imshow(B,[]);
end