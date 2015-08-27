% GLOBALS Declarations and definitions of global variables
%   This script declares and defines the global variables used by the
%   functions in this project.

%LAMBDA Regularization parameter in dictionary learning cost function
%   This variable defines the regularization parameter of the cost function
%   used in the dictionary learning process, the coefficient of the l1 norm
%   of the weights matrix. It is used by the functions that evaluate this
%   cost function (cost_dict_learning) and its derivative with respect to
%   the weights (update_weights).

global lambda;
lambda = 10;

%INIT_ETA Initial value of the learning rate for gradient descent
%   We implement gradient descent with a variable learning rate (eta). The
%   variable init_eta defines the initial value of eta.

global init_eta;
init_eta = 0.01;

%ETA_DEC_FACTOR Downward scaling of learning rate in case of failure
%   Over the course of gradient descent, whenever the computed update would
%   not result in a decrease in the value of the cost function, the step is
%   not taken, and the value of eta is instead scaled by a factor of
%   eta_dec_factor (which must, of course, lie strictly between 0 and 1).

global eta_dec_factor;
eta_dec_factor = 0.5;

%ETA_INC_FACTOR Upward scaling of learning rate in case of success
%   Whenever a valid update is found, the step is taken, and the value of
%   eta is scaled by a factor of eta_inc_factor (which should be at least
%   1).

global eta_inc_factor;
eta_inc_factor = 1.2;

%THRESH_FACTOR Termination condition for gradient descent
%   This variable describes the termination condition for our gradient
%   descent algorithm. The algorithm halts when the decrease in the value
%   of the cost function resulting from an update is less than
%   thresh_factor of its current value.

global thresh_factor;
thresh_factor = 0.01;