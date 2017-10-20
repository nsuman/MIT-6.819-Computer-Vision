% 6.869 Advances in Computer Vision
% Problem Set 3

% 10x magnification of motion
magnificationFactor = 10;

% width of Gaussian window
sigma = 13;

% alpha for moving average
alpha = 0.5;

%%

% read video file
videoFile = 'bill.avi';

reader = VideoReader(videoFile);
height = reader.height;
width = reader.width;
numFrames = reader.numberOfFrames;

frames = zeros(height, width, 3, numFrames);
reader = VideoReader(videoFile);
frameIndex = 1;
while hasFrame(reader)
    frames(:,:,:,frameIndex) = readFrame(reader);
    frameIndex = frameIndex + 1;
end
frames = double(frames) / 255;

%%

% we will magnify windows of the video and aggregate the results
magnified = zeros(size(frames));

% meshgrid for computing Gaussian window
[X,Y] = meshgrid(1:width, 1:height);

% iterate over windows of the frames
xRange = 1:2*sigma:width;
yRange = 1:2*sigma:height;
numWindows = length(xRange) * length(yRange);
windowIndex = 1;
for y = yRange
    for x = xRange
        
        % create windowed frames
        gaussianMask = exp((-(X-x).^2 - (Y- y).^2)/ (2 * sigma ^2 ));
        windowedFrames = gaussianMask .* frames;
        
        for channelIndex = 1:3 % RGB channels
            
            % initialize moving average of phase for current window/channel
            windowAveragePhase = angle(fft2(windowedFrames(:,:,channelIndex,1)));
            
            for frameIndex = 1:numFrames
                windowDft = fft2(windowedFrames(:,:,channelIndex,frameIndex));
                
                % compute phase shift and constrain to [-pi, pi] since
                % angle space wraps around
                windowPhaseShift = angle(windowDft) - windowAveragePhase;
                windowPhaseShift(windowPhaseShift > pi) ...
                    = windowPhaseShift(windowPhaseShift > pi) - 2 * pi;
                windowPhaseShift(windowPhaseShift < -pi) ...
                    = windowPhaseShift(windowPhaseShift < -pi) + 2 * pi;
                
                % magnify phase shift
                windowMagnifiedPhase = windowAveragePhase + windowPhaseShift * magnificationFactor;
                [m,n] = pol2cart(windowMagnifiedPhase, abs(windowDft));
                 
                % go back to image space
                windowMagnifiedDft = complex(m,n);
                windowMagnified = abs(ifft2(windowMagnifiedDft));
                
                % update moving average
                windowPhaseUnwrapped = windowAveragePhase + windowPhaseShift;
                windowAveragePhase = alpha * windowAveragePhase ...
                    + (1 - alpha) * windowPhaseUnwrapped;
                
                % aggregate
                magnified(:,:,channelIndex,frameIndex) ...
                    = magnified(:,:,channelIndex,frameIndex) + windowMagnified;
            end
        end
        
        % print progress
        fprintf('%d/%d\n', windowIndex, numWindows);
        windowIndex = windowIndex + 1;
    end
end

%%

% postprocess
magnified = magnified / max(magnified(:));
for channelIndex = 1:3
    originalFrame = frames(:,:,channelIndex,1);
    magnifiedFrame = magnified(:,:,channelIndex,1);
    scale = std(originalFrame(:)) / std(magnifiedFrame(:));
    originalMean = mean(originalFrame(:));
    magnifiedMean = mean(magnifiedFrame(:));
    magnified(:,:,channelIndex,:) = magnifiedMean + scale * (magnified(:,:,channelIndex,:) - magnifiedMean);
end
magnified = min(magnified, 1);
magnified = max(magnified, 0);

%%

% write motion-magnified video
writer = VideoWriter('bill_magnified.avi');
open(writer);
for frameIndex = 1:numFrames
    writeVideo(writer, magnified(:,:,:,frameIndex));
end
close(writer);
