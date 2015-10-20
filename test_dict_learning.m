n = 10;
m = 3;
X = zeros(m, n);

parfor i = 1:n
  I = eye(m);
  sel = randi(m);
  X(:, i) = I(:, sel);
end

X = normc(X + normrnd(0, 0.2, m, n));
G = X' * X;
[W1, U1] = dict_learning_lcc(G, m, 10, 1);
[W2, U2] = dict_learning_sc(G, m, 10, 1);