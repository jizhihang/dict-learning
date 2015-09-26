function cost = cost_sparsity( W )
%COST_SPARSITY Cost associated with the sparsity constraint
%   This function computes the cost associated with the sparsity constraint
%   imposed by sparse coding. The constraint is the sum of the (norm_p)th
%   powers of the norm_p norms of the columns of the weight matrix.

global norm_p

cost = sum(sum(arrayfun(@(x) abs(x)^norm_p, W)));
end