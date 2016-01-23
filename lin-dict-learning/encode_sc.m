function W = encode_sc( U, G, X, lam, p )
%ENCODE_SC Encodes a set with respect to a dictionary
%   This function computes the sparsity coding of a set of inputs with
%   respect to a set of dictionary atoms, themselves specified as a linear
%   combination of training inputs.

globals
global lambda norm_p
lambda = lam;
norm_p = p;

W = init_weights(U, X);
L = atom_log_product(U, G, X);
cur_cost = cost_sc(W, L);
[W, ~] = sparse_coding(W, L, cur_cost);
end