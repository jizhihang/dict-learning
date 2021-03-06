function update_W = update_weights_lcc( W, H, IU, UtGU )
%UPDATE_WEIGHTS_LCC Updates the dictionary weights of the inputs
%   This function computes the gradient of the cost function defined in
%   cost_lcc.m with respect to the weights, and is used along with it in
%   order to perform gradient descent on the weights in the locality
%   constrained coding part of the dictionary learning process.

%   The cost is a sum of a reconstruction term and a scaled locality
%   constraint term. The corresponding gradients are computed in
%   update_weights_reconstruction.m and update_weights_locality.m.

global lambda

update_W = update_weights_reconstruction(W, IU, UtGU) + ...
  (lambda * update_weights_locality(W, H, IU, UtGU));
end