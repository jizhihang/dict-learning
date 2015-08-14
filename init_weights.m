function ret = init_weights( D, X )
m = size(D, 2);
n = size(X, 2);

ret = zeros(m, n);
for j = 1:n
  for i = 1:m
    ret(i, j) = ...
      1 / (measure(log_map(D(1:end, i), X(1:end, j)), X(1:end, j)) + eps);
  end
  
  ret(1:end, j) = ret(1:end, j) / sum(ret(1:end, j));
end
end