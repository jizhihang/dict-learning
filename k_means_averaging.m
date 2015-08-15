function updated_D = k_means_averaging( X, D, L )
cur_cost = cost_clustering(X, D, L);
eta = 0.01;

while 1 
  new_D = update_atoms(X, D, L, eta);
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

function updated_D = update_atoms( X, D, L, eta )
grad = zeros(size(D));
for i = 1:size(D, 2)
  cluster = X(:, L == i);
  
  for j = 1:size(cluster, 2)
    grad(:, i) = grad(:, i) + ...
      log_map(cluster(:, j), D(:, i));
  end
end

updated_D = normc(D - (grad * eta));
end