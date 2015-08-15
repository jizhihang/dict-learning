function log_map = log_map( arg, base )
dot = arg' * base;
dir = arg - (base * dot);
log_map = dir * (my_acos(dot) * my_inv(norm(dir)));
end