function ret = k_means_clustering( X, m )
D = farthest_point_clustering(X, m);
L = k_means_labeling(X, D);
cur_cost = cost_clustering(X, D, L);
costs = zeros(1, 10000);
costs(1) = cur_cost;
index = 1;

while 1 
  new_D = k_means_averaging(X, D, L);
  new_L = k_means_labeling(X, D);
  new_cost = cost_clustering(X, new_D, new_L);

  if ((cur_cost - new_cost) > (0.000001 * cur_cost))
    D = new_D;
    L = new_L;
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

ret = new_D;
end