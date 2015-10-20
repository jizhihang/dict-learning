function cost = cost_reconstruction( W, L )
%COST_RECONSTRUCTION Reconstruction term of the dictionary learning cost
%   This function implements the cost associated with reconstructing the
%   inputs from the dictionary atoms. This cost is defined as the sum of
%   the squares of the norms of a weighted sum of the log maps of the
%   dictionary atoms with respect to the inputs, capturing a notion of
%   centrality of the atoms among the inputs.

n = size(W, 2);

costs = zeros(1, n);

parfor i = 1:n 
  costs(i) = W(:, i)' * L(:, :, i) * W(:, i);
end

cost = sum(costs);
end