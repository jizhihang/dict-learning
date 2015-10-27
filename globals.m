% GLOBALS Declarations and definitions of global variables
%   This script declares and defines the global variables used by the
%   functions in this project.

%LAMBDA Regularization parameter in dictionary learning cost function
%   This variable defines the regularization parameter of the cost function
%   used in the dictionary learning process. It is used by the functions
%   that evaluate this cost function and its gradients.

global lambda
lambda = 10;

%NORM_P Parameter of norm used in sparse dictionary learning cost
%   This variable specifies the norm to be applied to the weights matrix in
%   computing the cost function for dictionary learning, which captures a
%   notion of sparsity of the coding of any input in terms of the
%   dictionary atoms.

global norm_p
norm_p = 1;

%SIGMA Parameter of the locality constraint in the dictionary learning cost
%   This variable specifies the scale factor applied to the distance
%   between the inputs and the dictionary atoms. A larger value more
%   heavily penalizes large weights for faraway atoms.

global sigma
sigma = 1;

%INIT_ETA Initial value of the learning rate for gradient descent
%   We implement gradient descent with a variable learning rate (eta). The
%   variable init_eta defines the initial value of eta.

global init_eta
init_eta = 0.01;

%ETA_DEC_FACTOR Downward scaling of learning rate in case of failure
%   Over the course of gradient descent, whenever the computed update would
%   not result in a decrease in the value of the cost function, the step is
%   not taken, and the value of eta is instead scaled by a factor of
%   eta_dec_factor (which must, of course, lie strictly between 0 and 1).

global eta_dec_factor
eta_dec_factor = 0.1;

%ETA_INC_FACTOR Upward scaling of learning rate in case of success
%   Whenever a valid update is found, the step is taken, and the value of
%   eta is scaled by a factor of eta_inc_factor (which should be at least
%   1).

global eta_inc_factor
eta_inc_factor = 1.1;

%THRESH_FACTOR Termination condition for gradient descent
%   This variable describes the termination condition for our gradient
%   descent algorithm. The algorithm halts when the decrease in the value
%   of the cost function resulting from an update is less than
%   thresh_factor of its current value.

global thresh_factor
thresh_factor = 0.01;

%MAX_ITER Maximum number of iterations of convergence algorithms
%   This variable specifies the maximum number of iterations for which
%   various convergence algorithms are run, following which they are
%   terminated even if the specified termination conditions are not
%   satisfied.

global max_iter
max_iter = 10;