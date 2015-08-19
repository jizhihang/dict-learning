function D = k_means_clustering( X, m )
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

global thresh_factor

D = farthest_point_clustering(X, m);
L = k_means_labeling(X, D);
cur_cost = cost_clustering(X, D, L);

while 1 
  D = k_means_averaging(X, D, L);
  L = k_means_labeling(X, D);
  new_cost = cost_clustering(X, D, L);

  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
end
end