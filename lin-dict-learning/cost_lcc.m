function cost = cost_lcc( W, H, IU, UtGU )
%COST_LCC Cost function for dictionary learning
%   This function implements the cost function for locality constrained
%   dictionary learning. This, along with its gradient (computed in
%   update_atoms_lcc.m) are used in the gradient descent step of the
%   algorithm.
%
%   The cost is the sum of the cost associated with input reconstruction,
%   computed in cost_reconstruction.m, and a locality constraint, computed
%   in cost_locality.m, scaled by a regularization parameter (lambda).

global lambda

cost = cost_reconstruction(W, H, IU, UtGU) + ...
  (lambda * cost_locality(W, H, IU, UtGU));
end