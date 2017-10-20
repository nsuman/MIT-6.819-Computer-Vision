function image = myfunction(A, B, sigma)

loadA = imread(A);
double = im2double(loadA);
gaussianBlur = imgaussfilt(double, sigma);

loadB = imread(B);
doubleB = im2double(loadB);
image =  imgaussfilt(doubleB) + (double - gaussianBlur);
imshow(image)
end
