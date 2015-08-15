function updated_W = update_weights( W, D, X, eta )
%UPDATE_WEIGHTS Updates the dictionary weights of the inputs
%   This function computes the gradient of the cost function defined in
%   cost_dict_learning.m with respect to the weights, and is used along
%   with it in order to perform gradient descent on the weights in the
%   sparse coding part of the dictionary learning process. The updates for
%   the weights associated with each input are computed by the local
%   function norm_grad.

m = size(W, 1);
n = size(W, 2);

norm_grad_matrix = zeros(m, n);

for i = 1:n
  norm_grad_matrix(:, i) = norm_grad(W(:, i), D, X(:, i));
end

updated_W = W - (norm_grad_matrix * eta);
end

function grad = norm_grad( W_k, D, X_k )
%NORM_GRAD Computes the gradient for a single input
%   This function computes the gradient of the weights associated with a
%   single input. The cost function (defined in cost_dict_learning.m)
%   involves an l1 norm of the weights, and the derivative is approximated
%   by diff_huber.m. Note that the regularization parameter must match the
%   one used to define the cost function.

m = size(W_k, 1);

atom_logs = zeros(m);

for i = 1:m
  for j = 1:m
    atom_logs(i, j) = log_map(D(:, i), X_k)' * ...
      log_map(D(:, j), X_k);
  end
end

sgn = zeros(m, 1);

for i = 1:m
  sgn(i) = diff_huber(W_k(i));
end

grad = (sgn * 10) + (2 * (atom_logs * W_k));
grad = grad - (sum(grad) / m);
end