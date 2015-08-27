d = 10;
n = 100;
m = d;
X = zeros(d, n);

parfor i = 1:n
  I = eye(m);
  dim = randi(m);
  X(:, i) = normc((I(:, dim) * 5) + rand(d, 1) - 0.5);
end

[W, D] = dict_learning(X, m);
new_X = normc(D * W);