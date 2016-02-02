function cost = cost_locality( W, H, IU, UtGU )
%COST_LOCALITY Cost associated with the locality constraint
%   This function computes the cost associated with the locality constraint
%   imposed by LCC. The constraint is a sum of the squared exponentials of
%   a scaled distance between each input and each atom, multiplied by the
%   square of the respective weight.

global sigma
sig = sigma;

m = size(W, 1);
n = size(W, 2);

costs = zeros(1, m);

parfor j = 1:m
  for i = 1:n
    costs(j) = costs(j) + ...
      (W(j, i)^2 * ...
      exp(2 * sig * my_sqrt(H(i, i) - (2 * IU(i, j)) + UtGU(j, j))));
  end
end

cost = sum(costs);
end