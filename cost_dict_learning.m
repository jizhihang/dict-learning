function cost = cost_dict_learning( W, D, X )
%COST_DICT_LEARNING Cost function for dictionary learning
%   This function implements the cost function for sparse dictionary
%   learning. This, along with its gradient (computed in
%   update_atoms_global.m) are used in the gradient descent step of the
%   algorithm.
%
%   The cost is defined as the sum of the squares of the norms of a
%   weighted sum of the log maps of the dictionary atoms with respect to
%   the inputs, capturing a notion of centrality of the atoms among the
%   inputs. The regularization parameter for the l1 norm of the weight
%   matrix is set to 10.

d = size(X, 1);
m = size(D, 2);
n = size(X, 2);

cost = norm(W, 1) * 10;

for i = 1:n
  dist = zeros(d, 1);
  
  for j = 1:m
    dist = dist + (log_map(D(:, j), X(:, i)) * W(j, i));
  end
  
  cost = cost + norm(dist)^2;
end
end