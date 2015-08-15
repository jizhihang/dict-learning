function ret = codebook_optimization( W, D, X )
cur_cost = cost_dict_learning(W, D, X);
eta = 0.01;

while 1 
  new_D = update_weights(W, D, X, eta);
  new_cost = cost_dict_learning(W, new_D, X);

  if (cur_cost < new_cost)
    eta = eta / 2;
  elseif ((cur_cost - new_cost) > (0.01 * cur_cost))
    D = new_D;
    cur_cost = new_cost;
    eta = 1.2 * eta;
  else
    break;
  end
end

ret = new_D;
end

function ret = update_weights( W, D, X, eta )
d = size(D, 1);
m = size(D, 2);
n = size(X, 2);

logs = zeros(d, m, n);

for i = 1:m
  for j = 1:n
    logs(:, i, j) = log_map(D(:, i), X(:, j));
  end
end

w_logs = zeros(d, n);

for i = 1:n
  for j = 1:m
    w_logs(:, i) = w_logs(:, i) + (logs(:, j, i) * W(j, i));
  end
end

norm_grad_matrix = zeros(size(D));

for k = 1:m
  for i = 1:n
    dot = (D(:, k)' * X(:, i));
    arccos = my_acos(dot);
    dir = D(:, k) - (X(:, i) * dot);
    dist = norm(dir);
    log = logs(:, k, i);
    
    E_i = w_logs(:, i) - (W(k, i) * log);
    F_i = E_i - (X(:, i) * (E_i' * X(:, i)));
    G_i = (E_i' * log) * my_inv(arccos);
    
    vec = (((F_i * arccos) - (log * G_i)) * my_inv(dist)) - ...
        (X(:, i) * (((W(k, i) * arccos) + G_i) * my_inv(sqrt(1 - dot^2))));
    
    norm_grad_matrix(:, k) = ...
        norm_grad_matrix(:, k) + (vec * (2 * W(k, i)));
  end
end

ret = normc(D - (norm_grad_matrix * eta));
end