function [ W, U ] = dict_learning_lcc( G, m, lam, sig )
%DICT_LEARNING_LCC Learns a locality constrained dictionary representation
%of the input
%   This function combines the locality constrained coding and codebook
%   optimization processes (performing each one after the other until
%   convergence) in order to learn a locality constrained dictionary
%   representation of the input, of a specified size.
%
%   The algorithm initializes the dictionary using the k-means clustering
%   algorithm, and the weights using the procedure defined in
%   init_weights.m. The cost function used is the one defined and
%   implemented in cost_lcc.m.

globals
global lambda sigma thresh_factor max_iter
lambda = lam;
sigma = sig;

[U, L, UtGU] = k_means_clustering(G, m);
W = init_weights(L, m);
GU = G * U;
cur_cost = cost_lcc(W, G, GU, UtGU);

for i = 1:max_iter
  [W, new_cost] = ...
    locality_constrained_coding(W, G, cur_cost, GU, UtGU);

  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
  
  [U, new_cost, GU, UtGU] = codebook_opt_lcc(W, U, G, cur_cost);

  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;
  else
    break;
  end
end
end