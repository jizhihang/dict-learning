function ret = init_weights( D, X )
m = size(D, 2);
n = size(X, 2);

ret = zeros(m, n);
for i = 1:n
  for j = 1:m
    ret(j, i) = my_inv(my_acos(D(:, j)' * X(:, i)));
  end
  
  ret(:, i) = ret(:, i) / sum(ret(:, i));
end
end