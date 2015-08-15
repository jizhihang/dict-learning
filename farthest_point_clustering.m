function atoms = farthest_point_clustering( X, m )
d = size(X, 1);

atoms = zeros(d, m);
atoms(:, 1) = X(:, 1);
dot_matrix = zeros(m - 1, size(X, 2));

for i = 2:m
  dot_matrix(i - 1, :) = atoms(:, i - 1)' * X;
  [~, I] = min(max(dot_matrix(1:(i - 1), :)));
  atoms(:, i) = X(:, I);
end
end