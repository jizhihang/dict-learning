function update_W = update_weights_sparsity( W )
%UPDATE_WEIGHTS_SPARSITY Gradient of weights w.r.t. sparsity constraint
%   This function evaluates the gradient of the weights with respect to the
%   sparsity constraint defined in cost_sparsity.m. The cost function
%   involves a norm of the weights, and the derivative is approximated by
%   diff_huber.m.

global norm_p
p = norm_p;

m = size(W, 1);
n = size(W, 2);

update_W = zeros(m, n);

parfor i = 1:n
  for j = 1:m
    update_W(j, i) = p * diff_huber(W(j, i)) * ...
      my_inv(abs(W(j, i))^(1 - p));
  end
end
end