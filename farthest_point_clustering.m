function atoms = farthest_point_clustering( X, m )
%FARTHEST_POINT_CLUSTERING Computes a subset of "separated" points in a set
%   This function computes the farthest point clustering of a given size
%   for a given set of inputs, a set of points maximizing the minimum
%   distance between any two points in the set. This function is used to
%   initialize the dictionary computed by the k-means clustering algorithm.
%   Note that, on the unit sphere, the distances between pairs of points
%   can be compared by computing their dot products as well.

d = size(X, 1);
n = size(X, 2);

atoms = zeros(d, m);
atoms(:, 1) = X(:, 1);
dot_matrix = zeros(m - 1, n);

for i = 2:m
  dot_matrix(i - 1, :) = atoms(:, i - 1)' * X;
  [~, I] = min(max(dot_matrix(1:(i - 1), :), [], 1));
  atoms(:, i) = X(:, I);
end
end