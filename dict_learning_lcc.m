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
global lambda sigma thresh_factor
lambda = lam;
sigma = sig;

U = k_means_clustering(G, m);
W = init_weights(U, G);
cur_cost = cost_lcc(W, U, G);

%   Uncomment to plot cost function over iterations upto convergence
%{
costs = zeros(1, 10000);
costs(1) = cur_cost;
index = 1;
%}

while 1 
  W = locality_constrained_coding(W, U, G);
  U = codebook_opt_lcc(W, U, G);
  new_cost = cost_lcc(W, U, G);

  if ((cur_cost - new_cost) > (thresh_factor * cur_cost))
    cur_cost = new_cost;

    %{
    if (index == size(costs, 2))
      costs = [costs zeros(1, 10000)];
    end
    
    index = index + 1;
    costs(index) = cur_cost;
    %}
  else
    break;
  end
end

%{
figure(1); clf();
plot(costs(1, 1:index));
legend('cost');
%}
end