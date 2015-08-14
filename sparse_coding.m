function ret = sparse_coding(W, D, X )
cur_cost = cost_dict_learning(W, D, X);
%costs = zeros(1, 10000);
%costs(1) = cur_cost;
%index = 1;
eta = 0.01;

while 1 
  new_W = update_weights(W, D, X, eta);
  new_cost = cost_dict_learning(new_W, D, X);

  if (cur_cost < new_cost)
    eta = eta / 2;
  elseif ((cur_cost - new_cost) > (0.000001 * cur_cost))
    W = new_W;
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

ret = new_W;
end

function ret = update_weights( W, D, X, eta )
norm_grad_matrix = W;
for i = 1:size(W, 2)
  norm_grad_matrix(1:end, i) = norm_grad(W(1:end, i), D, X(1:end, i));
end

ret = W - (norm_grad_matrix * eta);
end

function ret = norm_grad( W_k, D, X_k )
lambda = 10;
m = size(W_k, 1);

atom_logs = zeros(m);
for i = 1:m
  for j = 1:m
    atom_logs(i, j) = inner_product(log_map(D(1:end, i), X_k), ...
                                    log_map(D(1:end, j), X_k), ...
                                    X_k);
  end
end

sgn = zeros(m, 1);
for i = 1:m
  sgn(i) = diff_huber(W_k(i));
end

grad = (sgn * lambda) + (2 * (atom_logs * W_k));
ret = grad - (sum(grad) / m);
end