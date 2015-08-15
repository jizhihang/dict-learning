function ret = init_weights( D, X )
%INIT_WEIGHTS Initializes the weights for dictionary learning
%   This function is used to initialize the weights learned by the sparse
%   dictionary learning process, implemented in dict_learning.m. As the
%   underlying cost function (computed in cost_dict_learning.m) involves a
%   weighted sum of the log maps of the atoms and the inputs, we initialize
%   the weights in inverse proportion to the norms of the log maps.

m = size(D, 2);
n = size(X, 2);

ret = zeros(m, n);
for i = 1:n
  for j = 1:m
    ret(j, i) = my_inv(my_acos(D(:, j)' * X(:, i)));
  end
  
  ret(:, i) = ret(:, i) / sum(ret(:, i));
end
end