function updated_W = sparse_coding( W, D, X )
%SPARSE_CODING Learns the best dictionary weights for the inputs
%   This function performs gradient descent to optimize the weights of the
%   inputs with respect to the dictionary. The underlying cost function is
%   computed in cost_dict_learning.m, and its gradient is computed in
%   update_weights.m.

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