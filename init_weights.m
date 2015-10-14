function weights = init_weights( U, G )
%INIT_WEIGHTS Initializes the weights for dictionary learning
%   This function is used to initialize the weights learned by the
%   dictionary learning process, As the underlying cost function involves a
%   weighted sum of the log maps of the atoms and the inputs, we initialize
%   the weights in inverse proportion to the norms of the log maps,
%   normalized to sum to 1 (as required by the algorithm).

n = size(U, 1);

weights = arrayfun(@(x) my_inv(my_acos(x)), U' * G);

parfor i = 1:n
  weights(:, i) = weights(:, i) * my_inv(sum(weights(:, i)));
end
end