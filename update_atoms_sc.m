function update_D = update_atoms_sc( W, D, X )
%UPDATE_ATOMS_SC Updates the dictionary atoms
%   This function computes the gradient of the cost function defined in
%   cost_sc.m with respect to the atoms, and is used along with it in order
%   to perform gradient descent on the atoms in the sparse coding part of
%   the dictionary learning process.

%   The cost is a sum of a reconstruction term and a scaled sparsity
%   constraint term. The sparsity constraint is independent of the atoms,
%   and the gradient of the reconstruction term is computed in
%   update_atoms_reconstruction.m.

update_D = update_atoms_reconstruction(W, D, X);
end