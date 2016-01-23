n = 500;
m = 20;
X = zeros(m, n);

parfor i = 1:n
  I = eye(m);
  sel = randi(m);
  X(:, i) = I(:, sel);
end

X = normc(X + normrnd(0, 0.2, m, n));
G = X' * X;
[W, U] = dict_learning_lcc(G, m, 10, 1);