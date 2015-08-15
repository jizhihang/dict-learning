function diff = diff_huber( x )
%DIFF_HUBER Computes the derivative of the Huber function
%   This function computes the derivative of the Huber function, a
%   parametrized differentiable approximation to the absolute value
%   function. This is used to approximate the cost function defined in
%   cost_dict_learning.m, in order to compute its gradient, in
%   update_weights.m. The approximation helps avoid oscillation of the
%   gradient of the function near the origin.
%
%   The function approximates the section of the graph between -beta and
%   +beta by a parabola of suitable curvature. The parameter beta can be
%   adjusted as desired.

beta = 0.00001;

if (abs(x) < beta)
  diff = x / beta;
else
  diff = sign(x);
end
end