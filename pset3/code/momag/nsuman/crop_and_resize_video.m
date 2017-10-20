% 6.869 Advances in Computer Vision
% Problem Set 3

% raw input video
reader = VideoReader('IMG_4453.mov');

% output video name
writer = VideoWriter('bill.avi');
open(writer);

frameIndex = 1;
framesToKeep = 68:127;
while hasFrame(reader)
    f = readFrame(reader);
    if ismember(frameIndex, framesToKeep)
        
        % square 720x720 crop of video
        cropped = imcrop(f, [0 240 720 720]);
        
        % downsample to 240x240
        resized = imresize(cropped, [240, 240]);
        
        writeVideo(writer, resized);
    end
    frameIndex = frameIndex + 1;
end
close(writer);
