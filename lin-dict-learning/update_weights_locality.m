function update_W = update_weights_locality( W, H, IU, UtGU )
%UPDATE_WEIGHTS_LOCALITY Gradient of weights w.r.t. locality constraint
%   This function evaluates the gradient of the weights with respect to the
%   locality constraint defined in cost_locality.m.

global sigma
sig = sigma;

m = size(W, 1);
n = size(W, 2);

update_W = zeros(m, n);

parfor j = 1:m
  for i = 1:n
    update_W(j, i) = 2 * W(j, i) * ...
      exp(2 * sig * my_sqrt(H(i, i) - (2 * IU(i, j)) + UtGU(j, j)));
  end
end
end