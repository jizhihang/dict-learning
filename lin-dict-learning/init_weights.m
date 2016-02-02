function weights = init_weights( L, m )
%INIT_WEIGHTS Initializes the weights for dictionary learning
%   This function is used to initialize the weights learned by the
%   dictionary learning process.

n = size(L, 1);

weights = zeros(m, n);

for i = 1:n
  weights(L(i), i) = 1;
end
end