function [ ] = reconstruct_image( in_name, out_name )
patch_size = 5;
var_thresh = 2500;

half = (patch_size - 1) / 2;
I = double(imread(in_name));
x = size(I, 1);
y = size(I, 2);
max_num_patches = ((x - patch_size - 1) * (y - patch_size - 1));

new_I = zeros(x, y);

counter = 0;
X = zeros(patch_size^2, max_num_patches);
means = zeros(1, max_num_patches);
vars = zeros(1, max_num_patches);
index = zeros(x, y);

for i = (1 + half):(x - half)
  for j = (1 + half):(y - half)
    patch = I((i - half):(i + half), (j - half):(j + half));
    patch = reshape(patch, patch_size^2, 1);    
    sigma = var(patch);

    if (sigma > var_thresh)
      mu = mean(patch);
      patch = (patch - mu) / sigma;
      counter = counter + 1;
      X(:, counter) = patch;
      means(counter) = mu;
      vars(counter) = sigma;
      index(i, j) = counter;
    end
  end
end

X = X(:, 1:counter);
[W, D] = dict_learning(X, 25);
new_X = normc(D * W);

count = zeros(x, y);

for i = (1 + half):(x - half)
  for j = (1 + half):(y - half)
    if(index(i, j) > 0)
      patch = (new_X(:, index(i, j)) * vars(index(i, j))) + ...
        means(index(i, j));
      new_I((i - half):(i + half), (j - half):(j + half)) = ...
        new_I((i - half):(i + half), (j - half):(j + half)) + ...
        reshape(patch, patch_size, patch_size);
      count((i - half):(i + half), (j - half):(j + half)) = ...
        count((i - half):(i + half), (j - half):(j + half)) + ...
        ones(patch_size, patch_size);
    end
  end
end

imwrite(uint8(new_I ./ count), out_name);
end