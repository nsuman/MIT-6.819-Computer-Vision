
function myfunction4(A)
img = imread(A);
[a,b,c] = size(img);
b
horizontal = fspecial('sobel');
doubleA = im2double(img);
imshow(doubleA)
size(doubleA)
vertical = horizontal';
for i = 1: ceil(b * 0.4)
    g_x = imfilter(doubleA, horizontal);
    g_y = imfilter(doubleA, vertical);
    g_squared = g_x.^2 + g_y.^2;
    min_value = getMinIndex(g_squared);
    doubleA(:,min_value,:)=[];
end
size(doubleA)
imshow(doubleA);
end

function idx = getMinIndex(A)
new_matrix = sum(A, 1);
[~, idx] = min(new_matrix);
end



