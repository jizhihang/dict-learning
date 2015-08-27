function cost = cost_clustering( X, D, L )
%COST_CLUSTERING Cost function for k-means clustering
%   This function computes the cost function for k-means clustering. This,
%   along with its gradient (computed in update_atoms_cluster.m), are used
%   in the gradient descent step of the k-means clustering algorithm,
%   implemented in k_means_*.m.
%
%   The cost is defined as the sum of the squares of the distances of each
%   input from its representative atom in the dictionary (which, on the
%   unit sphere, is just the arccosine of their dot product).

m = size(D, 2);

costs = zeros(m);

parfor i = 1:m
  cluster = X(:, L == i);
  dots = D(:, i)' * cluster;
  costs(i) = sum(arrayfun(@(x) my_acos(x)^2, dots));
end

cost = sum(costs);
end