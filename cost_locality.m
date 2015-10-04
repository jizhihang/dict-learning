function cost = cost_locality( W, D, X )
%COST_LOCALITY Cost associated with the locality constraint
%   This function computes the cost associated with the locality constraint
%   imposed by LCC. The constraint is a sum of the squared exponentials of
%   a scaled distance between each input and each atom, multiplied by the
%   square of the respective weight.

global sigma
sig = sigma;

m = size(D, 2);
n = size(X, 2);

costs = zeros(1, n);

parfor i = 1:n
  for j = 1:m
    costs(i) = costs(i) + ...
      (W(j, i)^2 * exp(2 * sig * my_acos(X(:, i)' * D(:, j))));
  end
end

cost = sum(costs);
end