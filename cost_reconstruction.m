function cost = cost_reconstruction( W, U, G )
%COST_RECONSTRUCTION Reconstruction term of the dictionary learning cost
%   This function implements the cost associated with reconstructing the
%   inputs from the dictionary atoms. This cost is defined as the sum of
%   the squares of the norms of a weighted sum of the log maps of the
%   dictionary atoms with respect to the inputs, capturing a notion of
%   centrality of the atoms among the inputs.

m = size(W, 1);
n = size(W, 2);

M = G * U;
N = U' * M;

costs = zeros(1, n);

parfor i = 1:n 
  L = zeros(m, m);

  for j = 1:m
    for k = j:m
      P = my_acos(M(i, j)) * my_acos(M(i, k)) * ...
        (N(j, k) - (M(i, j) * M(i, k))) * ...
        my_inv(my_sqrt((1 - M(i, j)^2) * (1 - M(i, k)^2)));
      L(j, k) = P;
      L(k, j) = P;
    end
  end
  
  costs(i) = W(:, i)' * L * W(:, i);
end

cost = sum(costs);
end