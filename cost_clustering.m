function cost = cost_clustering(X, D, L)
cost = 0;

for i = 1:size(D, 2)
  cluster = X(:, L == i);
  dots = D(:, i)' * cluster;
  
  for j = 1:size(dots, 2)
    cost = cost + ...
      arccos(sign(dots(j)) * min([abs(dots(j)), 1]))^2;
  end
end
end