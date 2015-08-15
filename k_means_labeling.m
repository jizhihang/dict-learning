function labels = k_means_labeling( X, D )
%K_MEANS_LABELING Labels the inputs with respect to the dictionary
%   This function computes the optimal labels for the inputs with respect
%   to a given set of atoms, i.e. for each input, it computes the atom that
%   is closest to it. On the unit sphere, the dot product provides for a
%   simple quantitative comparison between distances.

[~, labels] = max(D' * X);
end