function new_W = locality_constrained_coding( W, D, X )
%LOCALITY_CONSTRAINED_CODING Learns the best dictionary weights for the
%inputs
%   This function performs gradient descent to optimize the weights of the
%   inputs with respect to the dictionary. The underlying cost function is
%   computed in cost_lcc.m, and its gradient is computed in
%   update_weights_lcc.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

eta = init_eta;
cur_cost = cost_lcc(W, D, X);

while 1 
  update_W = update_weights_lcc(W, D, X);
  new_W = W - (update_W * eta);
  new_cost = cost_lcc(new_W, D, X);

  while (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
    new_W = W - (update_W * eta);
    new_cost = cost_lcc(new_W, D, X);
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