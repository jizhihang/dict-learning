function update_U = update_atoms_reconstruction( GU, WWt, WG )
%UPDATE_ATOMS_RECONSTRUCTION Gradient of atoms w.r.t. reconstruction term
%   This function evaluates the gradient of the atoms with respect to the
%   reconstruction term defined in cost_reconstruction.m.

update_U = 2 * ((GU * WWt) - WG');
end