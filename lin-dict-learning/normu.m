function normed_U = normu( U, G )
%NORMU Normalizes the dictionary atoms
%   This function normalizes the dictionary atoms so as to ensure that they
%   lie on the unit sphere. The atoms are represented as a linear
%   combination of the inputs, and the norm decomposes into kernel
%   functions of input pairs.

n = size(U, 1);
m = size(U, 2);

normed_U = zeros(n, m);

parfor i = 1:m
  normed_U(:, i) = U(:, i) * my_inv(my_sqrt((U(:, i)' * G * U(:, i))));
end
end