function updated_D = codebook_optimization( W, D, X )
%CODEBOOK_OPTIMIZATION Updates the dictionary
%   This function updates the dictionary atoms so as to be better able to
%   represent the inputs. We perform gradient descent on the dictionary;
%   the underlying cost function is computed in cost_dict_learning.m, and
%   its gradient is computed in update_atoms_global.m.

cur_cost = cost_dict_learning(W, D, X);
eta = 0.01;

while 1 
  new_D = update_atoms_global(W, D, X, eta);
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

updated_D = new_D;
end