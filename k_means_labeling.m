function labels = k_means_labeling( X, D )
[~, labels] = max(D' * X);
end