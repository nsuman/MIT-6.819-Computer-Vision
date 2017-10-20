% 6.869 Advances in Computer Vision
% Problem Set 3

% 9x9 images
imSize = 9;

% we would like to magnify the change between im1 and im2 by 4x
magnificationFactor = 4;

% horizontal movement from (1, 1) to (1, 2)
% additional vertical movement from (9, 9) to (8, 9)
im1 = zeros(imSize, imSize);
im2 = zeros(imSize, imSize);
im1(1,1) = 1;
im2(1,2) = 1;
im1(9,9) = 1;
im2(8,9) = 1;

% magnify position change
magnified = magnifyChange(im1, im2, magnificationFactor);

figure;
subplot(1,3,1);
imshow(im1); title('im1');
subplot(1,3,2);
imshow(im2); title('im2');
subplot(1,3,3);
imshow(magnified); title('magnified');
