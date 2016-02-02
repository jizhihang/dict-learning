function cost = cost_sc( W, H, IU, UtGU )
%COST_SC Cost function for dictionary learning
%   This function implements the cost function for sparse dictionary
%   learning. This, along with its gradient (computed in update_atoms_sc.m)
%   are used in the gradient descent step of the algorithm.
%
%   The cost is the sum of the cost associated with input reconstruction,
%   computed in cost_reconstruction.m, and a sparsity constraint, computed
%   in cost_sparsity.m, scaled by a regularization parameter (lambda).

global lambda

cost = cost_reconstruction(W, H, IU, UtGU) + (lambda * cost_sparsity(W));
end