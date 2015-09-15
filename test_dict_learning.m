d = 3;
n = 1000;
m = d;
X = zeros(d, n);

parfor i = 1:n
  I = eye(d);
  dim = randi(d);
  X(:, i) = normc((I(:, dim) * 5) + rand(d, 1) - 0.5);
end