function [ ] = reconstruct_image( filename )
patch_size = 3;
var_thresh = 1;

half = (patch_size - 1) / 2;
I = double(imread(strcat('img/', filename)));
x = size(I, 1);
y = size(I, 2);
c = size(I, 3);
max_num_patches = ((x - patch_size - 1) * (y - patch_size - 1));

counter = 0;
X = zeros(c * patch_size^2, max_num_patches);
index = zeros(x, y);

for i = (1 + half):(x - half)
  for j = (1 + half):(y - half)
    patch = I((i - half):(i + half), (j - half):(j + half), :);
    patch = reshape(patch, c * patch_size^2, 1);    
    sigma = var(patch);
    
    if (sigma < var_thresh)
      break;
    end
    
    mu = mean(patch);
    patch = (patch - mu) / sigma;
    counter = counter + 1;
    X(:, counter) = patch;
    index(i, j) = counter;
  end
end

X = X(:, 1:counter);
[W, D] = dict_learning(X, 50);
new_X = D * W;

new_I = zeros(x, y, c);
count = zeros(x, y, c);

for i = (1 + half):(x - half)
  for j = (1 + half):(y - half)
    if(index(i, j) > 0)
      new_I((i - half):(i + half), (j - half):(j + half), :) = ...
        new_I((i - half):(i + half), (j - half):(j + half), :) + ...
        reshape(new_X(:, index(i, j)), patch_size, patch_size, c);
      count((i - half):(i + half), (j - half):(j + half), :) = ...
        count((i - half):(i + half), (j - half):(j + half), :) + ...
        ones(patch_size, patch_size, c);
    end
  end
end

new_I = new_I ./ count;
imshow(uint8(new_I));
end