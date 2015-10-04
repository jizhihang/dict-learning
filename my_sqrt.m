function root = my_sqrt( x )
%MY_SQRT "Safe" version of the sqrt function
%   This function computes the square root of its argument, while being
%   sure to avoid a non-real answer. It does so by constraining the
%   argument to sqrt to be greater than or equal to 0.

root = sqrt(max(0, x));
end