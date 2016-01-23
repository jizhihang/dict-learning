function update_U = update_atoms_cluster( G, U, L )
%UPDATE_ATOMS_CLUSTER Computes the gradient for k-means clustering
%   This function computes the gradient of the cost function defined in
%   cost_clustering.m, and is used along with it to perform gradient
%   descent on the dictionary as part of the k-means clustering algorithm.
%
%   The cost function is a sum of squared norms of log maps. The atoms need
%   to be normalized after updation to ensure that they lie on the unit
%   sphere.

m = size(U, 2);
n = size(G, 1);

update_U = zeros(n, m);

parfor i = 1:m
  G_i = G(L == i, :);
  M_i = G_i * U(:, i);
  N_i = arrayfun(@(x) -2 * my_acos(x) * my_inv(my_sqrt(1 - x^2)), M_i);
  
  for j = 1:size(G_i)
    update_U(:, i) = update_U(:, i) + (N_i(j) * G_i(j, :)');
  end
end
end