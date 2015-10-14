function update_W = update_weights_reconstruction( W, U, G )
%UPDATE_WEIGHTS_RECONSTRUCTION Gradient of weights w.r.t. reconstruction
%term
%   This function evaluates the gradient of the weights with respect to the
%   reconstruction term defined in cost_reconstruction.m.

m = size(W, 1);
n = size(W, 2);

M = G * U;
N = U' * M;

parfor i = 1:n
  L = zeros(m, m);
  
  for j = 1:m
    for k = j:m
      P = my_acos(M(i, j)) * my_acos(M(i, k)) * ...
        (N(j, k) - (M(i, j) * M(i, k))) * ...
        my_inv(my_sqrt((1 - M(i, j)^2) * (1 - M(i, k)^2)));
      L(j, k) = P;
      L(k, j) = P;
    end
  end
  
  update_W(:, i) = 2 * L * W(:, i);
end
end