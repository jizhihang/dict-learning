function [ W, D ] = dict_learning( X, m, p, q )
%DICT_LEARNING Learns a sparse dictionary representation of the input
%   This function combines the sparse coding and codebook optimization
%   processes (performing each one after the other until convergence) in
%   order to learn a sparse dictionary representation of the input, of a
%   specified size.
%
%   The algorithm initializes the dictionary using the k-means clustering
%   algorithm, and the weights using the procedure defined in
%   init_weights.m. The cost function used is the one defined and
%   implemented in cost_dict_learning.m. In addition, we graph the cost
%   function over the course of the algorithm, up to convergence.

globals
global norm_p norm_q thresh_factor
norm_p = p;
norm_q = q;

D = k_means_clustering(X, m);
W = init_weights(D, X);
cur_cost = cost_dict_learning(W, D, X);

%   Uncomment to plot cost function over iterations upto convergence
%{
costs = zeros(1, 10000);
costs(1) = cur_cost;
index = 1;
%}

while 1 
  W = sparse_coding(W, D, X);
  D = codebook_optimization(W, D, X);
  new_cost = cost_dict_learning(W, D, X);

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