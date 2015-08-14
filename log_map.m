function ret = log_map( arg, base )
dot = arg' * base;
dir = arg - (dot * base);

ret = (acos((1 - eps) * dot) / (norm(dir) + eps)) * dir;
end