function updated_D = k_means_averaging( X, D, L )
% K_MEANS_AVERAGING Optimizes the clustering dictionary
%   This function optimizes the dictionary atoms given a labelling of the
%   inputs. This amounts to centering each atom in its cluster of inputs.
%   We use gradient descent; the underlying cost function is implemented in
%   cost_clustering.m and its gradient is computed by
%   update_atoms_cluster.m.

cur_cost = cost_clustering(X, D, L);
eta = 0.01;

while 1 
  new_D = update_atoms_cluster(X, D, L, eta);
  new_cost = cost_clustering(X, new_D, L);

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