function update_D = update_atoms_locality( W, D, X )
%UPDATE_ATOMS_LOCALITY Gradient of atoms w.r.t. locality constraint
%   This function evaluates the gradient of the atoms with respect to the
%   locality constraint defined in cost_locality.m.

global sigma
sig = sigma;

d = size(D, 1);
m = size(D, 2);
n = size(X, 2);

C = zeros(n, m);

parfor i = 1:n
  for j = 1:m
    diff = X(:, i) - D(:, j);
    mag = norm(diff);
    C(i, j) = - 2 * sig * W(j, i)^2 * exp(2 * sig * mag) / mag;
  end
end

update_D = (X * C) - (repmat(sum(C), d, 1) .* D);
end

