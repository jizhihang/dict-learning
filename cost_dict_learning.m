function cost = cost_dict_learning( W, D, X )
d = size(X, 1);
m = size(D, 2);
n = size(X, 2);

cost = norm(W, 1) * 10;

for i = 1:n
  dist = zeros(d, 1);
  
  for j = 1:m
    dist = dist + (log_map(D(:, j), X(:, i)) * W(j, i));
  end
  
  cost = cost + norm(dist)^2;
end
end