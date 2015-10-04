function update_D = update_atoms_locality( W, D, X )
%UPDATE_ATOMS_LOCALITY Gradient of atoms w.r.t. locality constraint
%   This function evaluates the gradient of the atoms with respect to the
%   locality constraint defined in cost_locality.m.

global sigma
sig = sigma;

m = size(D, 2);
n = size(X, 2);

C = zeros(n, m);

parfor i = 1:n
  for j = 1:m
    dot = X(:, i)' * D(:, j);
    C(i, j) = - 2 * sig * W(j, i)^2 * ...
      exp(2 * sig * my_acos(dot)) * my_inv(my_sqrt(1 - dot^2));
  end
end

update_D = (X * C);
end