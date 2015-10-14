function update_U = update_atoms_reconstruction( W, U, G )
%UPDATE_ATOMS_RECONSTRUCTION Gradient of atoms w.r.t. reconstruction term
%   This function evaluates the gradient of the atoms with respect to the
%   reconstruction term defined in cost_reconstruction.m.

m = size(W, 1);
n = size(W, 2);

update_U = zeros(n, m);

M = G * U;
N = U' * M;

for p = 1:n
  for q = 1:m
    for i = 1:n
      A = M(p, :) - (G(i, p) * M(i, :));
      B = N(q, :) - (M(i, q) * M(i, :));
      
      ac = arrayfun(@(x) my_acos(x), M(i, :));
      ri = arrayfun(@(x) my_inv(my_sqrt(1 - x^2)), M(i, :));
      cd = ac .* ri;
      C = G(i, p) * ((ac(q) * ri(q) * M(i, q)) - 1) * ri(q)^2 * cd;
      D = ac(q) * ri(q) * cd;
      
      E = (A .* D) + (B .* C);
      
      update_U(p, q) = update_U(p, q) + (2 * W(q, i) * E' * W(:, i));
    end
  end
end
end