function new_W = sparse_coding( W, D, X )
%SPARSE_CODING Learns the best dictionary weights for the inputs
%   This function performs gradient descent to optimize the weights of the
%   inputs with respect to the dictionary. The underlying cost function is
%   computed in cost_dict_learning.m, and its gradient is computed in
%   update_weights.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

d = size(D, 1);
m = size(D, 2);
n = size(X, 2);

eta = init_eta;
cur_cost = cost_dict_learning(W, D, X);

logs = zeros(d, m, n);

parfor j = 1:n
  for i = 1:m
    logs(:, i, j) = log_map(D(:, i), X(:, j));
  end
end

while 1 
  update_W = update_weights(W, logs);
  new_W = W - (update_W * eta);
  new_cost = cost_dict_learning(new_W, D, X);

  while (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
    new_W = W - (update_W * eta);
    new_cost = cost_dict_learning(new_W, D, X);
  end
  
  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    eta = eta_inc_factor * eta;
    W = new_W;
    cur_cost = new_cost;
  else
    break;
  end
end
end