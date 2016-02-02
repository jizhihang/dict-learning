function update_W = update_weights_reconstruction( W, IU, UtGU )
%UPDATE_WEIGHTS_RECONSTRUCTION Gradient of weights w.r.t. reconstruction
%term
%   This function evaluates the gradient of the weights with respect to the
%   reconstruction term defined in cost_reconstruction.m.

update_W = 2 * ((UtGU * W) - IU');
end