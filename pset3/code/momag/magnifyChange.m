% 6.869 Advances in Computer Vision
% Problem Set 3

function magnified = magnifyChange(im1, im2, magnificationFactor)
    % find phase shift in frequency domain
    im1Dft = fft2(im1);
    im2Dft = fft2(im2);
    phaseShift = angle(im2Dft) - angle(im1Dft);
    magnification = angle(im1Dft) + magnificationFactor * phaseShift;
    % magnify the phase change in frequency domain
    [m,n] = pol2cart(magnification, abs(im1Dft))
    % what does the magnified phase change cause in image space?
    magnified = ifft2(complex(m,n));
end