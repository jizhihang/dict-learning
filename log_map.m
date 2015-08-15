function log_map = log_map( arg, base )
%LOG_MAP Implements the log map on a sphere
%   This function implements the logarithm map on a sphere, which
%   associates with each point on the manifold (the base) and an element in
%   the tangent space of that point (the argument) a point on the manifold,
%   the second endpoint of a geodesic originating at the base, with tangent
%   at the base equal to the argument.

dot = arg' * base;
dir = arg - (base * dot);
log_map = dir * (my_acos(dot) * my_inv(norm(dir)));
end