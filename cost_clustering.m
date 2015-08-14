function ret = cost_clustering(X, D, L)
m = size(D, 2);
ret = 0;
for i = 1:m
  cluster = X(1:end, L == i);
  for j = 1:size(cluster, 2)
    dist = log_map(cluster(1:end, j), D(1:end, i));
    ret = ret + inner_product(dist, dist, D(1:end, i));
  end
end
end