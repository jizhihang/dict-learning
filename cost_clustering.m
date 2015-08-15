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

cost = 0;

for i = 1:m
  cluster = X(:, L == i);
  dots = D(:, i)' * cluster;
  
  for j = 1:size(dots, 2)
    cost = cost + my_acos(dots(j))^2;
  end
end
end