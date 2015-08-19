function updated_D = k_means_averaging( X, D, L )
% K_MEANS_AVERAGING Optimizes the clustering dictionary
%   This function optimizes the dictionary atoms given a labelling of the
%   inputs. This amounts to centering each atom in its cluster of inputs.
%   We use gradient descent; the underlying cost function is implemented in
%   cost_clustering.m and its gradient is computed by
%   update_atoms_cluster.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

cur_cost = cost_clustering(X, D, L);
eta = init_eta;

while 1 
  new_D = update_atoms_cluster(X, D, L, eta);
  new_cost = cost_clustering(X, new_D, L);

  if (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
  elseif ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    D = new_D;
    cur_cost = new_cost;
    eta = eta_inc_factor * eta;
  else
    break;
  end
end

updated_D = new_D;
end