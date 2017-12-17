function [output,scale,direction] = FrangiFilter(im)
% function [output,scale,direction] = FrangiFilter(im,options)
% Ham FrangiFilter dung vector truc giao Hessian de tinh toan tinh like
% -liness cua 1 vung anh dua theo pp Multiscale.
% 
% [output,scale,direction] = FrangiFilter(im,options)
% 
% inputs,
%   I : The input image (vessel image)
%   Options : Struct with input options,
%       .FrangiscaleRange   : Khoang xac dinh cua scale duoc su dung
%       .FrangiscaleRatio   : Step cua scale
%       .FrangiBetaOne      : Tham so Beta trong (2.15). Default b=0.5
%       .FrangiBetaTwo      : Tham so c trong (2.15), default c=15
% 
% outputs,
%   output      : The vessel enhanced image (pixel is the maximum found in
%                   all scales) 
%   scale       : Tra ve scale ma pixel dat cuc dai qua bo loc.
%   direction   : Huong cua pixel dua tren eigenvector nho hon.
% 
% Example,
%   I=double(imread ('vessel.png'));
%   Ivessel=FrangiFilter(I);
% 
% Written by Marc Schrijver, 2/11/2001
% Re-Written by D.Kroon University of Twente (May 2009)
% Re-Written by Quoc Du University of Science (December 2012)  


%     Convert gray to double
    if (~strcmp(class(im),'double'))
        im=double(im);
    end
    
    defaultoptions = struct('range', [2 6], 'ratio', 1.25, 'beta', 2.0, 'c', 450);
% %     Gan nhung gia tri options.
%     if (~exist('options','var'))
%         options=defaultoptions;     %   Gan nhung gia tri mac dinh cho tham so options.
%     else
%         tags = fieldnames(defaultoptions);
%         for i=1:length(tags)
%              if(~isfield(options,tags{i})),  options.(tags{i})=defaultoptions.(tags{i}); end
%         end
%         if(length(tags)~=length(fieldnames(options))), 
%             warning('FrangiFilter2D:Option co do dai khong khop');
%         end
%     end
    
%     Xac dinh so vong lap can thiet (1)
    loop=1;
    while(round(defaultoptions.range(1)*(defaultoptions.ratio)^loop) <= defaultoptions.range(2))
        loop=loop+1;
    end
    
    beta  = defaultoptions.beta;
    c     = defaultoptions.c;
    
%     Tao ra cac mang chua cac anh trung gian.
    ALLfiltered=zeros([size(im) loop]);
    ALLangles=zeros([size(im) loop]);
    
%     Loc Multiscale
    down=defaultoptions.range(1);   %2
    for i = 1:loop

        %   Tinh ma tran Hessian thong qua G(x,sigma)
        [Dxx,Dxy,Dyy] = Hessian(im,down);
        
        %   Cong thuc (2.2)
        Dxx = (down^2)*Dxx;
        Dxy = (down^2)*Dxy;
        Dyy = (down^2)*Dyy;

        %   Tinh tri rieng va vector rieng
        [Lambda1,Lambda2,Ix,Iy]=eig2image(Dxx,Dxy,Dyy);

        %   Tinh direction cac vector rieng
        angles = atan2(Ix,Iy);

        %   Tinh do tuong dong 
        Lambda2(Lambda2==0) = eps;
        Rb = (Lambda1./Lambda2).^2;     %   Cong thuc (2.10)
        S2 = Lambda2.^2 + Lambda1.^2;   %   Cong thuc (2.12)

        %   Anh output tuong ung voi scale
        Ifiltered = exp(-Rb/beta) .*(ones(size(im))-exp(-S2/c)); %   Cong thuc (2.13)
        Ifiltered(Lambda2<0)=0;     %   Cong thuc (6.6)
        
        %   Voi moi phan tu la mot anh sau khi loc tuong ung voi scale.
        ALLfiltered(:,:,i) = Ifiltered;
        ALLangles(:,:,i) = angles;
        
        down=down+defaultoptions.ratio;
    end
        largest_vessel= Ifiltered;

%     To hop gia tri likeliness theo cong thuc (2.14)
    if loop > 1
        [output,scale] = max(ALLfiltered,[],3);  %   Cong thuc (2.14)
        output = reshape(output,size(im));
        if(nargout>1)
            scale = reshape(scale,size(im));
        end
        if(nargout>2)
            direction = reshape(ALLangles((1:numel(im))'+(scale(:)-1)*numel(im)),size(im));
        end
    else
        output = reshape(ALLfiltered,size(im));
        if(nargout>1)
                scale = ones(size(im));
        end
        if(nargout>2)
            direction = reshape(ALLangles,size(im));
        end
    end

    direction=normal(direction);    %   Dua direction ve trong khoang [0,pi]
end