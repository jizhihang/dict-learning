function arccos = my_acos( x )
%MY_ACOS "Safe" version of the acos function
%   This function computes the arccosine of its argument, while being sure
%   to avoid a non-real answer. It does so by constraining the argument to
%   acos to lie between -1 and +1.

arccos = acos(sign(x) * min(abs(x), 1));
end