
function image = myfunction2 (image, sigma)
loadA = imread(image);
double = im2double(loadA);
gaussianBlur = imgaussfilt(double, sigma);
figure(1);
imshow(gaussianBlur);
image = double - gaussianBlur;

figure(2);
imshow(image);
end
