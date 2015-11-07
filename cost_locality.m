function cost = cost_locality( W, U, X )
%COST_LOCALITY Cost associated with the locality constraint
%   This function computes the cost associated with the locality constraint
%   imposed by LCC. The constraint is a sum of the squared exponentials of
%   a scaled distance between each input and each atom, multiplied by the
%   square of the respective weight.

global sigma
sig = sigma;

m = size(W, 1);
l = size(W, 2);

M = X' * U;

costs = zeros(1, l);

parfor i = 1:l
  for j = 1:m
    costs(i) = costs(i) + ...
      (W(j, i)^2 * exp(2 * sig * my_acos(M(i, j))));
  end
end

cost = sum(costs);
end