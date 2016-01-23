function labels = k_means_labeling( G, U )
%K_MEANS_LABELING Labels the inputs with respect to the dictionary
%   This function computes the optimal labels for the inputs with respect
%   to a given set of atoms, i.e. for each input, it computes the atom that
%   is closest to it.

[~, labels] = max(U' * G);
end