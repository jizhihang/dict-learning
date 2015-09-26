%{
n = 10000;
X = zeros(3, n);

parfor i = 1:n
  I = eye(3);
  del = randi(3);
  I(:, del) = [];
  lam = rand();
  mu = 0.5 * (1 - tan(0.5 * pi * (0.5 - lam)));
  X(:, i) = normc(((1 - mu) * I(:, 1)) + ((mu) * I(:, 2)));
end

X = normc(X + normrnd(0, 0.1, 3, n));

[W1, D1] = dict_learning_sc(X, 3, 10, 1, 1);
X1 = X;

parfor i = 1:n
  for j = 1:3
    X1(:, i) = X1(:, i) + (W1(j, i) * log_map(D1(:, j), X(:, i)));
  end
end

X1 = normc(X1);

[W2, D2] = dict_learning_sc(X, 3, 10, 0.5, 0.5);
X2 = X;

parfor i = 1:n
  for j = 1:3
    X2(:, i) = X2(:, i) + (W2(j, i) * log_map(D2(:, j), X(:, i)));
  end
end

X2 = normc(X2);

[W3, D3] = dict_learning_lcc(X, 3, 10, 1);
X3 = X;

parfor i = 1:n
  for j = 1:3
    X3(:, i) = X3(:, i) + (W3(j, i) * log_map(D3(:, j), X(:, i)));
  end
end

X3 = normc(X3);

diff1 = 0;
diff2 = 0;
diff3 = 0;

for i = 1:n
  diff1 = diff1 + my_acos(X(:, i)' * X1(:, i));
  diff2 = diff2 + my_acos(X(:, i)' * X2(:, i));
  diff3 = diff3 + my_acos(X(:, i)' * X3(:, i));
end
%}