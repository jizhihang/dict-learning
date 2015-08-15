function updated_W = sparse_coding(W, D, X )
cur_cost = cost_dict_learning(W, D, X);
eta = 0.01;

while 1 
  new_W = update_weights(W, D, X, eta);
  new_cost = cost_dict_learning(new_W, D, X);

  if (cur_cost < new_cost)
    eta = eta / 2;
  elseif ((cur_cost - new_cost) > (0.01 * cur_cost))
    W = new_W;
    cur_cost = new_cost;
    eta = 1.2 * eta;
  else
    break;
  end
end

updated_W = new_W;
end

function updated_W = update_weights( W, D, X, eta )
m = size(W, 1);
n = size(W, 2);

norm_grad_matrix = zeros(m, n);

for i = 1:n
  norm_grad_matrix(:, i) = norm_grad(W(:, i), D, X(:, i));
end

updated_W = W - (norm_grad_matrix * eta);
end

function grad = norm_grad( W_k, D, X_k )
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