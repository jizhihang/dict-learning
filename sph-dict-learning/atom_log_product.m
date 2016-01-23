function prod = atom_log_product( U, G, X )
%ATOM_LOG_PRODUCT Computes the inner products of the log maps of the atoms
%   This function computes the inner products of every pair of log maps of
%   dictionary atoms, with respect to every input.

m = size(U, 2);
l = size(X, 2);

M = X' * U;
N = U' * G * U;

prod = zeros(m, m, l);

parfor i = 1:l
  temp = zeros(m, m);
  
  for j = 1:m
    for k = j:m
      temp(j, k) = acos(sign(M(i, j)) * min(abs(M(i, j)), 1)) * ...
        acos(sign(M(i, k)) * min(abs(M(i, k)), 1)) * ...
        (N(j, k) - (M(i, j) * M(i, k))) / ...
        max(sqrt(max((1 - M(i, j)^2) * (1 - M(i, k)^2), 0)), 1.0e-10);
    end
  end
  
  prod(:, :, i) = temp + temp' - diag(diag(temp));
end
end