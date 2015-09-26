function cost = cost_reconstruction( W, D, X )
%COST_RECONSTRUCTION Reconstruction term of the dictionary learning cost
%   This function implements the cost associated with reconstructing the
%   inputs from the dictionary atoms. This cost is defined as the sum of
%   the squares of the norms of a weighted sum of the log maps of the
%   dictionary atoms with respect to the inputs, capturing a notion of
%   centrality of the atoms among the inputs.

d = size(X, 1);
m = size(D, 2);
n = size(X, 2);

costs = zeros(1, n);

parfor i = 1:n
  dist = zeros(d, 1);
  
  for j = 1:m
    dist = dist + (log_map(D(:, j), X(:, i)) * W(j, i));
  end
  
  costs(i) = norm(dist)^2;
end

cost = sum(costs);
end