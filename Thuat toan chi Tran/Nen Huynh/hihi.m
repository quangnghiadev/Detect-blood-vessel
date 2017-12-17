%% process
%choose 4 main directions of each part
DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'c',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Butterworth',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);


L = cell(1,9);

for i=1:9
    % DDFB
    m = 3;
    DirL = DDFB(J{i},m,8);
    
    n = 2^m;
    % Homomorphic filter
    if exist('midOption','var') && ~isempty(midOption)
        for k = 1 : n
            DirL(:,:,k) = midOption.func(DirL(:,:,k),midOption);
            %         figure, imagesc(DirL(:,:,k));
            %         figure, imshow(DirL(:,:,k), []);
        end
    end
    
    DirEnhance = DirectionalEnhance(DirL,DDFBoption);
    K = zeros(1,7);
    for k = 1 : n
        %     figure, imshow(DirEnhance(:,:,k), []);
        %figure, imagesc(DirEnhance(:,:,k));
        %Number of nonzero matrix elements
        K(k) = nnz(DirEnhance(:,:,k));
    end
    
    %choosing
    % S chua tri so cua 4 anh con co phan tu khac 0 lon nhat
    [B vt] = sort(K,'descend');
    
    sz = 4;
    S = vt(1:sz);
    S = sort(S);
    A = DirEnhance;
    count = 0;
    for k=1:sz
        A(:,:,S(k)-count) = [];
        count = count+1;
    end
    enhance = mean(A,3);
    
    L{i} = enhance;
    
end
