function labels = k_means_labeling( I, U, UtGU )
%K_MEANS_LABELING Labels the inputs with respect to the dictionary
%   This function computes the optimal labels for the inputs with respect
%   to a given set of atoms, i.e. for each input, it computes the atom that
%   is closest to it.

n = size(I, 1);
m = size(U, 2);

dists = zeros(n, m);

parfor j = 1:m
  dists(:, j) = repmat(UtGU(j, j), n, 1);
end

dists = dists - (2 * I * U);

[~, labels] = min(dists, [], 2);
end