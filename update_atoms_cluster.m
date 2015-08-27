function update_D = update_atoms_cluster( X, D, L )
%UPDATE_ATOMS_CLUSTER Computes the gradient for k-means clustering
%   This function computes the gradient of the cost function defined in
%   cost_clustering.m, and is used along with it to perform gradient
%   descent on the dictionary as part of the k-means clustering algorithm.
%
%   The cost function is a sum of squared norms of log maps, whose gradient
%   is simply the sum of the log maps themselves. However, the atoms need
%   to be normalized after updation to ensure that they lie on the unit
%   sphere.

d = size(D, 1);
m = size(D, 2);

update_D = zeros(d, m);

parfor i = 1:m
  cluster = X(:, L == i);
  
  for j = 1:size(cluster, 2)
    update_D(:, i) = update_D(:, i) + log_map(cluster(:, j), D(:, i));
  end
end
end