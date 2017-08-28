function [ii, jj] = Alcor(X)

X_flat = X(:)';

load('Alcor.mat')

[p] = stackedAEPredict(stackedAETheta, hiddenSize(end), ...
    outputSize, netconfig, X_flat);
X_judge = X(:, :, 3);

for k = 1 : 225
    [~, pred] = max(p, [], 1);
    if X_judge(pred(1)) == 1
        pred = pred(1);
        break;
    else
        p(pred) = -10;
    end
end
    



y = zeros(15);
y(pred) = 1;
y = reshape(y, 15 ,15);
[ii, jj] = find(y == 1);
end