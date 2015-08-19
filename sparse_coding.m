function updated_W = sparse_coding( W, D, X )
%SPARSE_CODING Learns the best dictionary weights for the inputs
%   This function performs gradient descent to optimize the weights of the
%   inputs with respect to the dictionary. The underlying cost function is
%   computed in cost_dict_learning.m, and its gradient is computed in
%   update_weights.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

cur_cost = cost_dict_learning(W, D, X);
eta = init_eta;

while 1 
  new_W = update_weights(W, D, X, eta);
  new_cost = cost_dict_learning(new_W, D, X);

  if (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
  elseif ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    W = new_W;
    cur_cost = new_cost;
    eta = eta_inc_factor * eta;
  else
    break;
  end
end

updated_W = new_W;
end