function update_U = update_atoms_locality( W, U, G, GU )
%UPDATE_ATOMS_LOCALITY Gradient of atoms w.r.t. locality constraint
%   This function evaluates the gradient of the atoms with respect to the
%   locality constraint defined in cost_locality.m.

global sigma
sig = sigma;

m = size(W, 1);
n = size(W, 2);

update_U = zeros(n, m);

parfor j = 1:m
  N = U(:, j)' * G * U(:, j);
  
  for k = 1:n
    dist = sqrt(max(G(k, k) - (2 * GU(k, j)) + N, 0));
    update_U(:, j) = update_U(:, j) + (2 * sig * W(j, k)^2 * ...
      exp(2 * sig * dist) * my_inv(dist) * (GU(:, j) - G(:, k)));
  end
end