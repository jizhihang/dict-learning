function atoms = farthest_point_clustering( G, m )
%FARTHEST_POINT_CLUSTERING Computes a subset of "separated" points in a set
%   This function computes the farthest point clustering of a given size
%   for a given set of inputs, a set of points maximizing the minimum
%   distance between any two points in the set. This function is used to
%   initialize the dictionary computed by the k-means clustering algorithm.

n = size(G, 1);

atoms = zeros(n, m);
atoms(1, 1) = 1;
dot_matrix = zeros(m - 1, n);

for i = 2:m
  dot_matrix(i - 1, :) = atoms(:, i - 1)' * G;
  [~, I] = min(max(dot_matrix(1:(i - 1), :), [], 1));
  atoms(I, i) = 1;
end
end