function [ new_U, new_L, new_cost ] = codebook_opt_sc( W, U, G, C )
%CODEBOOK_OPT_SC Updates the dictionary
%   This function updates the dictionary atoms so as to be better able to
%   represent the inputs. We perform gradient descent on the dictionary;
%   the underlying cost function is computed in cost_sc.m, and its gradient
%   is computed in update_atoms_sc.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

eta = init_eta;
cur_cost = C;

while 1 
  update_U = update_atoms_sc(W, U, G);
  new_U = normu(U - (update_U * eta), G);
  new_L = atom_log_product(U, G);
  new_cost = cost_sc(W, new_L);

  while (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
    new_U = normu(U - (update_U * eta), G);
    new_L = atom_log_product(U, G);
    new_cost = cost_sc(W, new_L);
  end
  
  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    eta = eta_inc_factor * eta;
    U = new_U;
    cur_cost = new_cost;
  else
    break;
  end
end
end