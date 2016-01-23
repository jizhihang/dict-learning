function update_U = update_atoms_locality( W, U, G )
%UPDATE_ATOMS_LOCALITY Gradient of atoms w.r.t. locality constraint
%   This function evaluates the gradient of the atoms with respect to the
%   locality constraint defined in cost_locality.m.

global sigma
sig = sigma;

m = size(W, 1);
n = size(W, 2);

M = G * U;

C = zeros(n, m);

parfor i = 1:n
  for j = 1:m
    C(i, j) = - 2 * sig * W(j, i)^2 * ...
      exp(2 * sig * my_acos(M(i, j))) * my_inv(my_sqrt(1 - M(i, j)^2));
  end
end

update_U = (G * C);
end