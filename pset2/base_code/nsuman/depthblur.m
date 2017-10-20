%% Read images and set up parameters.
im = imread('image.png');
imdouble = im2double(im);
depth = imread('depth.png');
depth = im2double(depth);
focal_plane_depth = 0.77;
alpha = 13;
[h,w,~] = size(im);


% Gaussian Filtering

result = zeros(h,w,3);


kernel_size = 20;
pad_size = kernel_size/2;

padded_image_r = padarray(imdouble, [pad_size, pad_size]);
figure(1);
imshow(padded_image_r);
for i = 1:h
    for j=1:w
        for k = 1:3
            
        dep = depth(i,j);
        % gussian sigma based on depth
        sigma_g = abs(dep-focal_plane_depth)*alpha;
        kernel_size = ceil(3*sigma_g);
        kernel = fspecial('gaussian', kernel_size, sigma_g);
        total = 0;
        shift = ceil(kernel_size/ 2);
        for uu = 1: kernel_size
            ii = i - ( uu - shift);
            for vv = 1:kernel_size
                 jj = j - ( vv - shift);
                 pixel_value = 1;
                 if ii < 1 || ii > h || jj < 1 || jj > w
                     pixel_value = 0;
                 else
                     pixel_value = imdouble(ii,jj,k);
                 end
                 
                 total = total + pixel_value * kernel(uu,vv);
            end
        end
        result(i,j,k) = total;
          
        % Implement your convolution code here
        end
    end
end
figure(3)
imshow(result)

%% Binomial Filtering
result_binomial = zeros(h,w,3);
% Add your code here
for i = 1:h
    for j=1:w
        for k = 1:3
        dep = depth(i,j);
        % gussian sigma based on depth
        sigma_g = abs(dep-focal_plane_depth)*alpha;
        kernel_size = ceil(3*sigma_g)*10;
        kernel = combination(kernel_size)' * combination(kernel_size) ;
        norm_kernel = kernel./sum(sum(combination(kernel_size)))^2;
        total = 0;
        shift = floor(kernel_size/ 2);
        for uu = 1: kernel_size
            ii = i - ( uu - shift);
            for vv = 1:kernel_size
                 jj = j - ( vv - shift);
                 pixel_value = 1;
                 if ii < 1 || ii > h || jj < 1 || jj > w
                     pixel_value = 0;
                 else
                     pixel_value = imdouble(ii,jj,k);
                 end
                 
                 total = total + pixel_value * norm_kernel(uu,vv);
            end
        end
        result_binomial(i,j,k) = total;

        % Implement your convolution code here
        end
    end
end

figure(4);
imshow(uint8(result_binomial))

function result = combination(n)
m1 = floor(n/2);
m2 = ceil(n/2);
k = 1:m2;
result = [1 cumprod((n-k+1)./k)];
result(n+1:-1:m1+2) = result(1:m2);
end
