function [ new_U, new_cost, Gnew_U, new_UtGnew_U ] = ...
  codebook_opt_sc( W, U, G, C )
%CODEBOOK_OPT_SC Updates the dictionary
%   This function updates the dictionary atoms so as to be better able to
%   represent the inputs. We perform gradient descent on the dictionary;
%   the underlying cost function is computed in cost_sc.m, and its gradient
%   is computed in update_atoms_sc.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor max_iter

WWt = W * W';
WG = W * G;

eta = init_eta;
cur_cost = C;

for i = 1:max_iter
  update_U = update_atoms_sc(U, G, WWt, WG);
  new_U = U - (update_U * eta);
  Gnew_U = G * new_U;
  new_UtGnew_U = new_U' * Gnew_U;
  new_cost = cost_sc(W, G, Gnew_U, new_UtGnew_U);

  for j = 1:max_iter
    if (cur_cost > new_cost)
      break;
    end
    
    eta = eta_dec_factor * eta;
    new_U = U - (update_U * eta);
    Gnew_U = G * new_U;
    new_UtGnew_U = new_U' * Gnew_U;
    new_cost = cost_sc(W, G, Gnew_U, new_UtGnew_U);
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