function update_U = update_atoms_lcc( W, U, G, WWt, WG )
%UPDATE_ATOMS_LCC Updates the dictionary atoms
%   This function computes the gradient of the cost function defined in
%   cost_lcc.m with respect to the atoms, and is used along with it in
%   order to perform gradient descent on the atoms in the locality
%   constrained coding part of the dictionary learning process.

%   The cost is a sum of a reconstruction term and a scaled locality
%   constraint term. The corresponding gradients are computed in
%   update_atoms_reconstruction.m and update_atoms_locality.m.

global lambda

GU = G * U;

update_U = update_atoms_reconstruction(GU, WWt, WG) + ...
  (lambda * update_atoms_locality(W, U, G, GU));
end