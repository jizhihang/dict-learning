function W = encode_lcc( U, G, X, lam, sig )
%ENCODE_LCC Encodes a set with respect to a dictionary
%   This function computes the locality constrained coding of a set of
%   inputs with respect to a set of dictionary atoms, themselves specified
%   as a linear combination of training inputs.

globals
global lambda sigma
lambda = lam;
sigma = sig;

W = init_weights(U, X);
L = atom_log_product(U, G, X);
cur_cost = cost_lcc(W, U, X, L);
[W, ~] = locality_constrained_coding(W, U, X, L, cur_cost);
end