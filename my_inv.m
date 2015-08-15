function inv = my_inv( x )
%MY_INV "Safe" reciprocal
%   This function computes the reciprocal of a non-negative number, being
%   sure to avoid a NaN answer by truncating the input below a certain
%   threshold.

inv = 1 / max(x, 1.0e-10);
end