im = imread('test.jpg');
[nr nc] = size(im);

t = ddfb_4_stages(im,3,52); %directional filter


angle = -[pi/4, 3*pi/8, pi/2, 5*pi/8, 6*pi/8, 7*pi/8, 0, pi/8]; %angles corresponds to directions t1..t8 

vi = cell(size(im));
for i=1:nr
    for j=1:nc
        tmp=[];
        for k=1:8,
            tmp=[tmp t{k}(i,j)];
        end        
        [c idx] = max(tmp);
        
        vi{i,j} = double(c)*[cos(angle(idx)), sin(angle(idx))];        
                      
    end
end

for i=1:size(vi,1),
for j=1:size(vi,2),
    if ~isempty(vi{i,j})
        vix(i,j) = vi{i,j}(1);
        viy(i,j) = vi{i,j}(2);
    end
end
end

iidx = 250:300;
jidx = 120:170;
for i=1:length(iidx)
for j=1:length(jidx)
if ~isempty(vi{iidx(i),jidx(j)})
        vix1(i,j) = vi{iidx(i),jidx(j)}(1);
        viy1(i,j) = vi{iidx(i),jidx(j)}(2);
    end
end
end

figure;imagesc(im(iidx,jidx));colormap gray; hold on;
quiver(vix1,viy1);title('original directional vector field');axis ij;
