
function question4(A)
img = imread(A);
horizontal = fspecial('sobel');
doubleA = im2double(img);
[a,b,c] = size(img);
imshow(doubleA)
size(doubleA)
vertical = horizontal';
x = 0.4 * a
for i = 1:x
    
    g_x = imfilter(doubleA, horizontal);
    g_y = imfilter(doubleA, vertical);
    g_squared = g_x.^2 + g_y.^2;
    min_value = getMinIndex(g_squared);
    %disp(min_value)
%     disp(min_value); 
%     disp(x)
%     size(doubleA)
    doubleA(:,min_value,:)=[];
end
size(doubleA)
imshow(doubleA);
end

function idx = getMinIndex(A)
new_matrix = sum(A, 1);
[~, idx] = min(new_matrix);
end



