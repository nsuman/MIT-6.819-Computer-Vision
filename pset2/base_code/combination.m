function result = combination(n)
m1 = floor(n/2);
m2 = ceil(n/2);
k = 1:m2;
result = [1 cumprod((n-k+1)./k)];
result(n+1:-1:m1+2) = result(1:m2);
end