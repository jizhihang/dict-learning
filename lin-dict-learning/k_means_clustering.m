function [ U, L, UtGU ] = k_means_clustering( G, m )
%K_MEANS_CLUSTERING Computes a clustering dictionary for a given input
%   This function implements the k-means clustering algorithm, determining
%   a set of atoms of given size so as to minimize the least distance of
%   each input from an atom.
%
%   The dictionary is initialized using the farthest point clustering
%   algorithm, and the dictionary and labels are alternately updated using
%   the procedures in k_means_averaging.m and k_means_labeling.m,
%   performing gradient descent with respect to the cost function defined
%   in cost_clustering.m.

global thresh_factor max_iter

U = farthest_point_clustering(G, m);
UtG = U' * G;
UtGU = UtG * U;
L = k_means_labeling(G, U, UtGU);
cur_cost = cost_clustering(G, U, L, UtG, UtGU);

for i = 1:max_iter
  [U, new_cost, UtG, UtGU] = k_means_averaging(G, U, L, cur_cost);
  
  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
  
  L = k_means_labeling(G, U, UtGU);
  
  new_cost = cost_clustering(G, U, L, UtG, UtGU);

  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
end
end