function [ W, U ] = dict_learning_sc( G, m, lam, p )
%DICT_LEARNING_SC Learns a sparse dictionary representation of the input
%   This function combines the sparse coding and codebook optimization
%   processes (performing each one after the other until convergence) in
%   order to learn a sparse dictionary representation of the input, of a
%   specified size.
%
%   The algorithm initializes the dictionary using the k-means clustering
%   algorithm, and the weights using the procedure defined in
%   init_weights.m. The cost function used is the one defined and
%   implemented in cost_sc.m.

globals
global lambda norm_p thresh_factor max_iter
lambda = lam;
norm_p = p;

[U, L, UtGU] = k_means_clustering(G, m);
W = init_weights(L, m);
GU = G * U;
cur_cost = cost_sc(W, G, GU, UtGU);

for i = 1:max_iter
  [W, new_cost] = sparse_coding(W, G, cur_cost, GU, UtGU);

  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
  
  [U, new_cost, GU, UtGU] = codebook_opt_sc(W, U, G, cur_cost);
  
  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
end
end