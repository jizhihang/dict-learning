function ret = farthest_point_clustering( X, m )
n = size(X, 2);
ret = X(1:end, 1:m);
for i = 2:m
  dists = zeros(n, 1);
  for j = 1:n
    dist = inf;
    for k = 1:(i - 1)
      dist = min(dist, measure(log_map(X(1:end, j), ret(1:end, k)), ...
                               ret(1:end, k)));
    end
    dists(j) = dist;
  end
  [~, I] = max(dists);
  ret(i) = X(1:end, I);
end
end