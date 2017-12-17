function create_files(dcm_file, frames)
    data=dicomread(dcm_file);
    data=data(:,:,:);
    for frame=frames
        link = strcat(dcm_file(1:end-4),int2str(frame),'.jpg');
        Img = data(:,:,frame);
        imwrite(Img,link,'jpg');
    end
end