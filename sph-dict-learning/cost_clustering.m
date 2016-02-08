function cost = cost_clustering( G, U, L )
%COST_CLUSTERING Cost function for k-means clustering
%   This function computes the cost function for k-means clustering. This,
%   along with its gradient (computed in update_atoms_cluster.m), are used
%   in the gradient descent step of the k-means clustering algorithm,
%   implemented in k_means_*.m.
%
%   The cost is defined as the sum of the squares of the distances of each
%   input from its representative atom in the dictionary.

m = size(U, 2);

costs = zeros(1, m);

parfor i = 1:m
  G_i = G(L == i, :);
  M_i = G_i * U(:, i);
  costs(i) = sum(arrayfun(@(x) my_acos(x)^2, M_i));
end

cost = sum(costs);
end