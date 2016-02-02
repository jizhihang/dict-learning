function cost = cost_reconstruction( W, H, IU, UtGU )
%COST_RECONSTRUCTION Reconstruction term of the dictionary learning cost
%   This function implements the cost associated with reconstructing the
%   inputs from the dictionary atoms. This cost is defined as the sum of
%   the squared distances of the input points from their reconstructions in
%   terms of the dictionary atoms, defined as a weighted sum.

n = size(W, 2);

costs = zeros(1, n);

parfor i = 1:n
  costs(i) = (W(:, i)' * UtGU * W(:, i)) - (2 * IU(i, :) * W(:, i));
end

cost = sum(diag(H)) + sum(costs);
end