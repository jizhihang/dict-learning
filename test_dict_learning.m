d = 10;
n = 20;

m = d;
I = eye(m);
X = zeros(d, n);

for i = 1:n
  dim = randi(m);
  X(:, i) = normc((I(:, dim) * 5) + rand(d, 1) - 0.5);
end

[W, D] = dict_learning(X, m);
new_X = D * W;