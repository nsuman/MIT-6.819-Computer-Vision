function [ scaled_im ] = intensityscale( raw_img )
    [sx,sy,c]=size(raw_img);
    ima = raw_img(:);
    ima = (ima - min(ima(:))); % remove the minimun intensity value
    ima = 255 * ima / max(ima(:)); % divide by the maximum intensity value
    meangray=mean(ima);
    for n=1:size(ima,1)
        ima(n,:) = (ima(n,:)-(meangray-128)); % make the image with a mean intensity of 128
    end
    ima=reshape(ima,sx,sx); % put back the 1d vector into a 2d image
    
    % clipping
    j = find(ima<0); ima(j) = 0;
    j = find(ima>255); ima(j) = 255;
    
    scaled_im = ima;
end

