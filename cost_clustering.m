function cost = cost_clustering(X, D, L)
m = size(D, 2);

cost = 0;

for i = 1:m
  cluster = X(:, L == i);
  dots = D(:, i)' * cluster;
  
  for j = 1:size(dots, 2)
    cost = cost + my_acos(dots(j))^2;
  end
end
end