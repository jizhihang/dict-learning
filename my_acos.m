function arccos = my_acos( x )
  arccos = acos(sign(x) * min(abs(x), 1));
end