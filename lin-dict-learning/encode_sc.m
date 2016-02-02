function W = encode_sc( U, G, H, I, lam, p )
%ENCODE_SC Encodes a set with respect to a dictionary
%   This function computes the sparsity coding of a set of inputs with
%   respect to a set of dictionary atoms, themselves specified as a linear
%   combination of training inputs.

globals
global lambda norm_p
lambda = lam;
norm_p = p;

UtGU = U' * G * U;
L = k_means_labeling(I, U, UtGU);
m = size(U, 2);
W = init_weights(L, m);
IU = I * U;
cur_cost = cost_sc(W, H, IU, UtGU);
[W, ~] = sparse_coding(W, H, cur_cost, IU, UtGU);
end