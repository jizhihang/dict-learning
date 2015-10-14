function update_W = update_weights_locality( W, U, G )
%UPDATE_WEIGHTS_LOCALITY Gradient of weights w.r.t. locality constraint
%   This function evaluates the gradient of the weights with respect to the
%   locality constraint defined in cost_locality.m.

global sigma
sig = sigma;

m = size(W, 1);
n = size(W, 2);

M = G * U;

update_W = zeros(m, n);

parfor i = 1:n
  for j = 1:m
    update_W(j, i) = 2 * W(j, i) * exp(2 * sig * my_acos(M(i, j)));
  end
end
end