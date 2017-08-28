function [theta, cost] = stackminiBatchNadam(theta, alpha, beta1, beta2, epsilon, num_iters, batch_size, ...
                                             hiddenSize, outputSize, netconfig, lambda)

saldir2 = './data2/';
% load([strcat(saldir2, 'data_', num2str(1)), '.mat'])
% XX = X;
% yy = y;
l = length(theta);
m = zeros(l, 1);
v = zeros(l, 1);
tt = 1 : num_iters + 1;
Beta1 = beta1 .* (1 - 0.5 .* 0.96 .^ (tt ./ 250));
g_circumflex = zeros(l, 1);
m_circumflex = zeros(l, 1);
v_circumflex = zeros(l, 1);
m_flat = zeros(l, 1);
for t = 1 : num_iters
    %% 此处为直接调用data
    XX = [];
    yy = [];
    % 取540组训练
    rp = randperm(540);
%     for data_iter = 1 : 5
        load([strcat(saldir2, 'data_', num2str(rp(1))), '.mat'])
        XX = [XX; X];
        yy = [yy; y];
%     end
    %%
    [X_batch, y_batch] = miniBatchXy(XX, yy, batch_size);
    [cost, g] = stackedAECost(theta, hiddenSize, outputSize, ...
                              netconfig, lambda, X_batch, y_batch);
    g_circumflex = g ./ (1 - prod(Beta1(1 : t)));
    m = beta1 * m + (1 - beta1) * g;
    m_circumflex = m ./ (1 - prod(Beta1(1 : t + 1)));
    v = beta2 * v + (1 - beta2) * g .^ 2;
    v_circumflex = v ./ (1 - beta2 ^ (t));
    m_flat = (1 - Beta1(t)) * g_circumflex + Beta1(t + 1) * m_circumflex;
    delta = alpha * m_flat ./ (sqrt(v_circumflex) + epsilon);
    theta = theta - delta;
    fprintf('%d %d %d\n', t, cost, norm(delta))
end

    