function image = Q1(A, B, sigma)

loadA = imread(A);
double = im2double(A);
gaussianBlur = imgaussfilt(double, sigma);

image =  imgaussfilt(B) + (A - gaussianBlur);
imshow(image)
end


a =  Q1('image.png', 'image.png', 10);