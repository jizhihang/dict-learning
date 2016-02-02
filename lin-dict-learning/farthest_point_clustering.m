function atoms = farthest_point_clustering( G, m )
%FARTHEST_POINT_CLUSTERING Computes a subset of "separated" points in a set
%   This function computes the farthest point clustering of a given size
%   for a given set of inputs, a set of points maximizing the minimum
%   distance between any two points in the set. This function is used to
%   initialize the dictionary computed by the k-means clustering algorithm.

n = size(G, 1);

indices = zeros(m);
indices(1) = 1;

for i = 2:m
  vals = zeros(n);
  
  for j = 1:n
    temps = zeros(i - 1);
    
    for k = 1:(i - 1)
      temps(k) = G(indices(k), indices(k)) - (2 * G(j, indices(k)));
    end
    
    [~, vals(i)] = min(max(temps));
  end
  
  [~, indices(i)] = min(max(vals));
end

atoms = zeros(n, m);

for i = 1:m
  atoms(indices(i), i) = 1;
end
end