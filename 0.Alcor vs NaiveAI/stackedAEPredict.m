function [p] = stackedAEPredict(theta, lastHiddenSize, ...
                                   outputSize, netconfig, X)

softmaxTheta = reshape(theta(1 : lastHiddenSize * outputSize), ...
    outputSize, lastHiddenSize);

stack = params2stack(theta(lastHiddenSize * outputSize + 1 : end), netconfig);

depth = numel(stack);
z = cell(depth + 1, 1);
a = cell(depth + 1, 1);
a{1} = X;

for layer = 1 : depth
  z{layer + 1} = a{layer} * stack{layer}.w' + ...
      repmat(stack{layer}.b, 1, size(a{layer}, 1))';
  a{layer + 1} = sigmoid(z{layer + 1});
end

[~, pred] = max(softmaxTheta * a{depth + 1}');
p = softmaxTheta * a{depth + 1}';
%p = full(sparse(pred, 1 : length(pred), 1))';

end