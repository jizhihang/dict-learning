function update_W = update_weights_sc( W, U, G )
%UPDATE_WEIGHTS_SC Updates the dictionary weights of the inputs
%   This function computes the gradient of the cost function defined in
%   cost_sc.m with respect to the weights, and is used along with it in
%   order to perform gradient descent on the weights in the sparse coding
%   part of the dictionary learning process.

%   The cost is a sum of a reconstruction term and a scaled sparsity
%   constraint term. The corresponding gradients are computed in
%   update_weights_reconstruction.m and update_weights_sparsity.m. Note
%   that the sum of the weights of any input must be normalized to 1.

global lambda

m = size(W, 1);
n = size(W, 2);

update_W = update_weights_reconstruction(W, U, G) + ...
  (lambda * update_weights_sparsity(W));

parfor i = 1:n
  update_W(:, i) = update_W(:, i) - (sum(update_W(:, i)) / m);
end
end