function [X_batch, y_batch] = miniBatchXy(X, y, batch_size)
r = randperm(size(X, 1));
X_batch = X(r(1 : batch_size), :);
y_batch = y(r(1 : batch_size), :);