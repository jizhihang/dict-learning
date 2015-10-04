n = 1000;
X = zeros(3, n);
%{
parfor i = 1:n
  I = eye(3);
  del = randi(3);
  I(:, del) = [];
  lam = rand();
  mu = 0.5 * (1 - tan(0.5 * pi * (0.5 - lam)));
  X(:, i) = normc(((1 - mu) * I(:, 1)) + ((mu) * I(:, 2)));
end
%}

parfor i = 1:n
  I = eye(3);
  del = randi(3);
  X(:, i) = I(:, del);
end

X = normc(X + normrnd(0, 0.1, 3, n));

[W1, D1] = dict_learning_sc(X, 3, 10, 1);
[W2, D2] = dict_learning_lcc(X, 3, 10, 1);

%{
f = zeros(1, 1000);
g = zeros(1, 1000);

for i = 1:1000
  [W1, D1] = dict_learning_sc(X, 3, i, 1);
  f(i) = cost_reconstruction(W1, D1, X);
  g(i) = cost_sparsity(W1);
end

figure(1); clf();
plot(f, g);


[W2, D2] = dict_learning_lcc(X, 3, 10, 1);
X2 = X;

parfor i = 1:n
  for j = 1:3
    X2(:, i) = X2(:, i) + (W2(j, i) * log_map(D2(:, j), X(:, i)));
  end
end

X2 = normc(X2);

diff1 = 0;
diff2 = 0;

for i = 1:n
  diff1 = diff1 + my_acos(X(:, i)' * X1(:, i));
  diff2 = diff2 + my_acos(X(:, i)' * X2(:, i));
end
%}