function new_U = codebook_opt_lcc( W, U, G )
%CODEBOOK_OPT_LCC Updates the dictionary
%   This function updates the dictionary atoms so as to be better able to
%   represent the inputs. We perform gradient descent on the dictionary;
%   the underlying cost function is computed in cost_lcc.m, and its
%   gradient is computed in update_atoms_lcc.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

eta = init_eta;
cur_cost = cost_lcc(W, U, G);

while 1 
  update_U = update_atoms_lcc(W, U, G);
  new_U = normu(U - (update_U * eta), G);
  new_cost = cost_lcc(W, new_U, G);

  while (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
    new_U = normu(U - (update_U * eta), G);
    new_cost = cost_lcc(W, new_U, G);
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