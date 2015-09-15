function update_W = update_weights( W, D, X )
%UPDATE_WEIGHTS Updates the dictionary weights of the inputs
%   This function computes the gradient of the cost function defined in
%   cost_dict_learning.m with respect to the weights, and is used along
%   with it in order to perform gradient descent on the weights in the
%   sparse coding part of the dictionary learning process.
%
%   The cost function involves an l1 norm of the weights, and the
%   derivative is approximated by diff_huber.m. Note that the
%   regularization parameter must match the one used to define the cost
%   function. The sum of the weights of any input must also be normalized
%   to 1.

global norm_p norm_q
p = norm_p;
q = norm_q;

m = size(W, 1);
n = size(W, 2);

update_W = zeros(m, n);

parfor i = 1:n
  N = p * (norm(W(:, i), p)^(p * ((1 / q) - 1))) / q;
  
  for j = 1:m
    update_W(j, i) = N * diff_huber(W(j, i)) / (abs(W(j, i))^(1 - p));
  end
end

parfor i = 1:n
  atom_logs = zeros(m, m);
  
  for j = 1:m
    for k = 1:m
      atom_logs(j, k) = 2 * (log_map(D(:, j), X(:, i))' * ...
        log_map(D(:, k), X(:, i)));
    end
  end
  
  update_W(:, i) = update_W(:, i) + (atom_logs * W(:, i));
  update_W(:, i) = update_W(:, i) - (sum(update_W(:, i)) / m);
end
end