function ret = cost_dict_learning( W, D, X )
lambda = 10;
ret = 0;

for i = 1:size(X, 2)
  dist = zeros(size(X, 1), 1);
  for j = 1:size(D, 2)
    dist = dist + (log_map(D(1:end, j), X(1:end, i)) * W(j, i));
  end
  
  ret = ret + inner_product(dist, dist, X(1:end, i));
end

ret = ret + (norm(W, 1) * lambda);
end