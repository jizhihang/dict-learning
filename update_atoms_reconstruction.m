function update_D = update_atoms_reconstruction( W, D, X )
%UPDATE_ATOMS_RECONSTRUCTION Gradient of atoms w.r.t. reconstruction term
%   This function evaluates the gradient of the atoms with respect to the
%   reconstruction term defined in cost_reconstruction.m.

d = size(D, 1);
m = size(D, 2);
n = size(X, 2);

w_logs = zeros(d, n);

parfor i = 1:n
  for j = 1:m
    w_logs(:, i) = w_logs(:, i) + (log_map(D(:, j), X(:, i)) * W(j, i));
  end
end

update_D = zeros(d, m);

parfor k = 1:m
  for i = 1:n
    dot = (D(:, k)' * X(:, i));
    arccos = my_acos(dot);
    dir = D(:, k) - (X(:, i) * dot);
    dist = norm(dir);
    log = log_map(D(:, k), X(:, i));
    
    E_i = w_logs(:, i) - (W(k, i) * log);
    F_i = E_i - (X(:, i) * (E_i' * X(:, i)));
    G_i = (E_i' * log) * my_inv(arccos);
    
    vec = (((F_i * arccos) - (log * G_i)) * my_inv(dist)) - ...
      (X(:, i) * (((W(k, i) * arccos) + G_i) * ...
      my_inv(my_sqrt(1 - dot^2))));
    
    update_D(:, k) = update_D(:, k) + (vec * (2 * W(k, i)));
  end
end
end