function ret = k_means_averaging( X, D, L )
cur_cost = cost_clustering(X, D, L);
%costs = zeros(1, 10000);
%costs(1) = cur_cost;
%index = 1;
eta = 0.01;

while 1 
  new_D = update_atoms(X, D, L, eta);
  new_cost = cost_clustering(X, new_D, L);

  if (cur_cost < new_cost)
    eta = eta / 2;
  elseif ((cur_cost - new_cost) > (0.000001 * cur_cost))
    D = new_D;
    cur_cost = new_cost;
    
    %if (index == size(costs, 2))
    %  costs = [costs zeros(1, 10000)];
    %end
    
    %index = index + 1;
    %costs(index) = cur_cost;
    eta = 1.2 * eta;
  else
    break;
  end
end

%figure(1); clf();
%plot(costs(1, 1:index));
%legend('cost');

ret = new_D;
end

function ret = update_atoms( X, D, L, eta )
m = size(D, 2);
ret = zeros(size(D));
for i = 1:m
  cluster = X(1:end, L == i);
  for j = 1:size(cluster, 2)
    ret(1:end, m) = ret(1:end, m) + ...
                    log_map(cluster(1:end, j), D(1:end, m));
  end
end
ret = D - (ret * eta);
for i = 1:m
  ret(1:end, i) = ret(1:end, i) / norm(ret(1:end, i));
end
end