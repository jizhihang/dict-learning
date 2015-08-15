function ret = codebook_optimization( W, D, X )
cur_cost = cost_dict_learning(W, D, X);
%costs = zeros(1, 10000);
%costs(1) = cur_cost;
%index = 1;
eta = 0.01;

while 1 
  new_D = update_weights(W, D, X, eta);
  new_cost = cost_dict_learning(W, new_D, X);

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

function ret = update_weights( W, D, X, eta )
m = size(D, 2);
n = size(X, 2);
d = size(D, 1);

logs = zeros(d, m, n);
for i = 1:m
  for j = 1:n
    logs(1:end, i, j) = log_map(D(1:end, i), X(1:end, j));
  end
end

w_logs = zeros(d, n);
for i = 1:n
  for j = 1:m
    w_logs(1:end, i) = w_logs(1:end, i) + (logs(1:end, j, i) * W(j, i));
  end
end

norm_grad_matrix = D;
for k = 1:m
  norm_grad_matrix(1:end, k) = zeros(d, 1);
  for i = 1:n
    dot = (D(1:end, k)' * X(1:end, i));
    arccos = acos((1 - eps) * dot);
    dir = D(1:end, k) - (X(1:end, i) * dot);
    dist = norm(dir);
    log = logs(1:end, k, i);
    E_i = w_logs(1:end, i) - (W(k, i) * log);
    F_i = E_i - (X(1:end, i) * (E_i' * X(1:end, i)));
    G_i = (E_i' * log) / (arccos + eps);
    vec = (((F_i * arccos) - (log * G_i)) / (dist + eps)) - ...
        (X(1:end, i) * (((W(k, i) * arccos) + G_i) / ...
        (sqrt(1 - dot^2) + eps)));
    norm_grad_matrix(1:end, k) = ...
        norm_grad_matrix(1:end, k) + (vec * (2 * W(k, i)));
  end
end

ret = D - (norm_grad_matrix * eta);
for i = 1:m
  ret(1:end, i) = ret(1:end, i) / norm(ret(1:end, i));
end
end