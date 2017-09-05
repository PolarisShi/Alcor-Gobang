function [J, grad] = stackedAECost(theta, lastHiddenSize, ...
                                   outputSize, netconfig, ...
                                   lambda, X, y, G)

softmaxTheta = reshape(theta(1 : lastHiddenSize * outputSize), ...
    outputSize, lastHiddenSize);

stack = params2stack(theta(lastHiddenSize * outputSize + 1 : end), netconfig);

stackgrad = cell(size(stack));
for d = 1:numel(stack)
    stackgrad{d}.w = zeros(size(stack{d}.w));
    stackgrad{d}.b = zeros(size(stack{d}.b));
end

depth = numel(stack);
z = cell(depth + 1, 1);
a = cell(depth + 1, 1);
a{1} = X;

for layer = 1 : depth
  z{layer + 1} = a{layer} * stack{layer}.w' + ...
      repmat(stack{layer}.b, 1, size(a{layer}, 1))';
  a{layer + 1} = sigmoid(z{layer + 1});
end

M = softmaxTheta * a{depth+1}';
M = bsxfun(@minus, M, max(M));

p = bsxfun(@rdivide, exp(M), sum(exp(M)));

yt = y';


J = -1 / outputSize * yt(:)' * log(p(:)) + ...
    lambda / 2 * sum(softmaxTheta(:) .^ 2);
% bsxfun(@times, (yt - p), G') ´úÌæ (yt - p)
softmaxThetaGrad = -1 / outputSize * bsxfun(@times, (yt - p), G') * a{depth + 1} + ...
    lambda * softmaxTheta;

d = cell(depth + 1);
% bsxfun(@times, (yt - p), G') ´úÌæ (yt - p)
d{depth + 1} = -(softmaxTheta' * bsxfun(@times, (yt - p), G')) .* sigmoidGradient(z{layer + 1}');%a{depth + 1}' .* (1 - a{depth + 1}');

for layer = depth : -1 : 2
  d{layer} = (stack{layer}.w' * d{layer + 1}) .* sigmoidGradient(z{layer}');
end

for layer = depth : -1 : 1
  stackgrad{layer}.w = 1 / outputSize * d{layer+1} * a{layer} + lambda / outputSize * stack{layer}.w;
  stackgrad{layer}.b = 1 / outputSize * sum(d{layer + 1}, 2);
end

grad = [softmaxThetaGrad(:); stack2params(stackgrad)];

end