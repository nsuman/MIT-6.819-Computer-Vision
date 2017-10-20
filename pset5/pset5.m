
face = load('faces.mat');
%get the covarience_matrix 
cov_mat = cov(face.faces');
[vectors,D] = eigs(cov_mat,400);

size(vectors)
for ii = 1:5
    image = vectors(:,ii);
    size(image)
    image = reshape(image,[64,64]);
    figure 
    colormap gray 
    imagesc(image)
    title("plot of the image" + ii)
end
matrix = face.faces;
first_imge = matrix(:,1);
[vectors, D] = eigs(cov_mat, 20);
coef = mldivide(vectors, first_imge);

first_20 = vectors * coef;
first_20 = reshape(first_20, [64,64]);

figure 
imagesc(first_20);
colormap gray
title("first 20 basis approximation")
