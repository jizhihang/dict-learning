function update_U = update_atoms_reconstruction( W, U, G )
%UPDATE_ATOMS_RECONSTRUCTION Gradient of atoms w.r.t. reconstruction term
%   This function evaluates the gradient of the atoms with respect to the
%   reconstruction term defined in cost_reconstruction.m.

m = size(W, 1);
n = size(W, 2);

update_U = zeros(n, m);

M = G * U;
N = U' * M;
P = arrayfun(@(x) my_acos(x) * my_inv(my_sqrt(1 - x^2)), M);
WP = W .* P';

for i = 1:n
  GM = G(:, i) * M(i, :);
  
  parfor q = 1:m
    g = ((P(i, q) * M(i, q)) - 1) * my_inv(1 - M(i, q)^2);
    B = (P(i, q) * M) + (g * G(:, i) * N(q, :)) - ...
      ((P(i, q) + (g * M(i, q))) * GM);

    update_U(:, q) = update_U(:, q) + ...
      (2 * W(q, i) * B * WP(:, i));
  end
end
end