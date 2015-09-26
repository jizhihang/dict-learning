function update_W = update_weights_reconstruction( W, D, X )
%UPDATE_WEIGHTS_RECONSTRUCTION Gradient of weights w.r.t. reconstruction
%term
%   This function evaluates the gradient of the weights with respect to the
%   reconstruction term defined in cost_reconstruction.m.

m = size(W, 1);
n = size(W, 2);

update_W = zeros(m, n);

parfor i = 1:n
  atom_logs = zeros(m, m);
  
  for j = 1:m
    for k = 1:m
      atom_logs(j, k) = 2 * (log_map(D(:, j), X(:, i))' * ...
        log_map(D(:, k), X(:, i)));
    end
  end
  
  update_W(:, i) = atom_logs * W(:, i);
end
end