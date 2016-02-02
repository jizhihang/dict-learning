function W = encode_lcc( U, G, H, I, lam, sig )
%ENCODE_LCC Encodes a set with respect to a dictionary
%   This function computes the locality constrained coding of a set of
%   inputs with respect to a set of dictionary atoms, themselves specified
%   as a linear combination of training inputs.

globals
global lambda sigma
lambda = lam;
sigma = sig;

UtGU = U' * G * U;
L = k_means_labeling(I, U, UtGU);
m = size(U, 2);
W = init_weights(L, m);
IU = I * U;
cur_cost = cost_lcc(W, H, IU, UtGU);
[W, ~] = locality_constrained_coding(W, H, cur_cost, IU, UtGU);
end