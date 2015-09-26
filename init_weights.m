function weights = init_weights( D, X )
%INIT_WEIGHTS Initializes the weights for dictionary learning
%   This function is used to initialize the weights learned by the
%   dictionary learning process, As the underlying cost function involves a
%   weighted sum of the log maps of the atoms and the inputs, we initialize
%   the weights in inverse proportion to the norms of the log maps,
%   normalized to sum to 1 (as required by the algorithm).

m = size(D, 2);
n = size(X, 2);

weights = zeros(m, n);

parfor i = 1:n
  weights(:, i) = arrayfun(@(x) my_inv(my_acos(D(:, x)' * X(:, i))), 1:m);
  weights(:, i) = weights(:, i) / sum(weights(:, i));
end
end