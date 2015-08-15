function D = k_means_clustering( X, m )
D = farthest_point_clustering(X, m);
L = k_means_labeling(X, D);
cur_cost = cost_clustering(X, D, L);

while 1 
  D = k_means_averaging(X, D, L);
  L = k_means_labeling(X, D);
  new_cost = cost_clustering(X, D, L);

  if ((cur_cost - new_cost) > (0.01 * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
end
end