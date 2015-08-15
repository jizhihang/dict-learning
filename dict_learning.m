function [W, D] = dict_learning( X, m )
D = k_means_clustering(X, m);
W = init_weights(D, X);
cur_cost = cost_dict_learning(W, D, X);

costs = zeros(1, 10000);
costs(1) = cur_cost;
index = 1;

while 1 
  W = sparse_coding(W, D, X);
  D = codebook_optimization(W, D, X);
  new_cost = cost_dict_learning(W, D, X);

  if ((cur_cost - new_cost) > (0.01 * cur_cost))
    cur_cost = new_cost;
    
    if (index == size(costs, 2))
      costs = [costs zeros(1, 10000)];
    end
    
    index = index + 1;
    costs(index) = cur_cost;
  else
    break;
  end
end

figure(1); clf();
plot(costs(1, 1:index));
legend('cost');
end