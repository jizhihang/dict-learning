function update_U = update_atoms_cluster( G, U, L )
%UPDATE_ATOMS_CLUSTER Computes the gradient for k-means clustering
%   This function computes the gradient of the cost function defined in
%   cost_clustering.m, and is used along with it to perform gradient
%   descent on the dictionary as part of the k-means clustering algorithm.

m = size(U, 2);
n = size(G, 1);

update_U = 2 * G * U;

parfor i = 1:m
  G_i = G(L == i, :);
  sz_i = size(G_i, 1);
  
  for j = 1:n
    update_U(j, i) = (update_U(j, i) * sz_i) - (2 * sum(G_i(:, j)));
  end
end
end