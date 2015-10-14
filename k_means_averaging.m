function new_U = k_means_averaging( G, U, L )
% K_MEANS_AVERAGING Optimizes the clustering dictionary
%   This function optimizes the dictionary atoms given a labelling of the
%   inputs. This amounts to centering each atom in its cluster of inputs.
%   We use gradient descent; the underlying cost function is implemented in
%   cost_clustering.m and its gradient is computed by
%   update_atoms_cluster.m.

global init_eta eta_dec_factor eta_inc_factor thresh_factor

eta = init_eta;
cur_cost = cost_clustering(G, U, L);

while 1 
  update_U = update_atoms_cluster(G, U, L);
  new_U = normu(U - (update_U * eta));
  new_cost = cost_clustering(G, new_U, L);

  while (cur_cost < new_cost)
    eta = eta_dec_factor * eta;
    new_U = normu(U - (update_U * eta));
    new_cost = cost_clustering(G, new_U, L);
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