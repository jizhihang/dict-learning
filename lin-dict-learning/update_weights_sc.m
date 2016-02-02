function update_W = update_weights_sc( W, IU, UtGU )
%UPDATE_WEIGHTS_SC Updates the dictionary weights of the inputs
%   This function computes the gradient of the cost function defined in
%   cost_sc.m with respect to the weights, and is used along with it in
%   order to perform gradient descent on the weights in the sparse coding
%   part of the dictionary learning process.

%   The cost is a sum of a reconstruction term and a scaled sparsity
%   constraint term. The corresponding gradients are computed in
%   update_weights_reconstruction.m and update_weights_sparsity.m.

global lambda

update_W = update_weights_reconstruction(W, IU, UtGU) + ...
  (lambda * update_weights_sparsity(W));
end