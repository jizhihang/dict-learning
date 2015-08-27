function new_D = codebook_optimization( W, D, X )
%CODEBOOK_OPTIMIZATION Updates the dictionary
%   This function updates the dictionary atoms so as to be better able to
%   represent the inputs. We perform gradient descent on the dictionary;
%   the underlying cost function is computed in cost_dict_learning.m, and
%   its gradient is computed in update_atoms_global.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

eta = init_eta;
cur_cost = cost_dict_learning(W, D, X);

while 1 
  update_D = update_atoms_global(W, D, X);
  new_D = normc(D - (update_D * eta));
  new_cost = cost_dict_learning(W, new_D, X);

  while (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
    new_D = normc(D - (update_D * eta));
    new_cost = cost_dict_learning(W, new_D, X);
  end
  
  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    eta = eta_inc_factor * eta;
    D = new_D;
    cur_cost = new_cost;
  else
    break;
  end
end
end