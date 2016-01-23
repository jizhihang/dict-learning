function update_W = update_weights_reconstruction( W, L )
%UPDATE_WEIGHTS_RECONSTRUCTION Gradient of weights w.r.t. reconstruction
%term
%   This function evaluates the gradient of the weights with respect to the
%   reconstruction term defined in cost_reconstruction.m.

l = size(W, 2);

parfor i = 1:l
  update_W(:, i) = 2 * L(:, :, i) * W(:, i);
end
end