function inv = my_inv( x )
%MY_INV "Safe" reciprocal
%   This function computes the reciprocal of a number, being sure to avoid
%   a NaN answer by truncating the input below a certain threshold.

inv = sign(x) / max(abs(x), 1.0e-10);
end