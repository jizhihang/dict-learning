function update_D = update_atoms_global( W, D, X )
%UPDATE_ATOMS_GLOBAL Computes the gradient for codebook optimization
%   This function computes the gradient for the cost function computed in
%   cost_dict_learning.m with respect to the dictionary atoms. The output
%   is used in performing gradient descent on the dictionary atoms in the
%   codebook optimization stage of the sparse dictionary learning process,
%   implemented in codebook_optimization.m. The updated atoms are
%   normalized to ensure that they lie on the unit sphere.

d = size(D, 1);
m = size(D, 2);
n = size(X, 2);

logs = zeros(d, m, n);

parfor j = 1:n
  for i = 1:m
    logs(:, i, j) = log_map(D(:, i), X(:, j));
  end
end

w_logs = zeros(d, n);

parfor i = 1:n
  for j = 1:m
    w_logs(:, i) = w_logs(:, i) + (logs(:, j, i) * W(j, i));
  end
end

update_D = zeros(d, m);

parfor k = 1:m
  for i = 1:n
    dot = (D(:, k)' * X(:, i));
    arccos = my_acos(dot);
    dir = D(:, k) - (X(:, i) * dot);
    dist = norm(dir);
    log = logs(:, k, i);
    
    E_i = w_logs(:, i) - (W(k, i) * log);
    F_i = E_i - (X(:, i) * (E_i' * X(:, i)));
    G_i = (E_i' * log) * my_inv(arccos);
    
    vec = (((F_i * arccos) - (log * G_i)) * my_inv(dist)) - ...
      (X(:, i) * (((W(k, i) * arccos) + G_i) * my_inv(sqrt(1 - dot^2))));
    
    update_D(:, k) = ...
      update_D(:, k) + (vec * (2 * W(k, i)));
  end
end
end