clc, clear all, close all;

% 初始化网络
inputSize = 15 * 15 * 8;
hiddenSize = [500, 500, 300];
num_labels = 15 * 15;
outputSize = num_labels;


stack = cell(length(hiddenSize), 1);

stack{1}.optTheta = initializeParameters(hiddenSize(1), inputSize);
    
    
stack{1}.w = reshape(stack{1}.optTheta(1 : hiddenSize(1) * inputSize), ...
    hiddenSize(1), inputSize);
stack{1}.b = stack{1}.optTheta(2 * hiddenSize(1) * inputSize + 1 : ...
    2 * hiddenSize(1) * inputSize + hiddenSize(1));
 
    
for ii = 2 : length(hiddenSize)
    stack{ii}.optTheta = initializeParameters(hiddenSize(ii), hiddenSize(ii - 1));
    
    stack{ii}.w = reshape(stack{ii}.optTheta(1 : hiddenSize(ii) * ...
        hiddenSize(ii - 1)), hiddenSize(ii), hiddenSize(ii - 1));
    stack{ii}.b = stack{ii}.optTheta(2 * hiddenSize(ii) * ...
        hiddenSize(ii - 1) + 1 : 2 * hiddenSize(ii) * ...
        hiddenSize(ii - 1) + hiddenSize(ii));
end

[stackparams, netconfig] = stack2params(stack);

softmaxTheta = 0.005 * randn(num_labels  * hiddenSize(end), 1);
stackedAETheta = [softmaxTheta; stackparams];

% 网络参数
lambda = 3e-3;
alpha = 0.001;
beta1 = 0.99;
beta2 = 0.999;
epsilon = 1e-8;
num_iters = 20000;
batch_size = 1200;

% 训练
[stackedAETheta, cost] = stackminiBatchNadam ...
    (stackedAETheta, alpha, beta1, beta2, epsilon, num_iters, batch_size, ...
     hiddenSize(end), outputSize, netconfig, lambda);
     

% 测试
% 541至550组为测试集
saldir2 = './data2/';
Xtest = [];
ytest = [];
for data_iter = 541 : 550
    load([strcat(saldir2, 'data_', num2str(data_iter)), '.mat'])
    Xtest = [Xtest; X];
    ytest = [ytest; y];
end

    
[p] = stackedAEPredict(stackedAETheta, hiddenSize(end), ...
    outputSize, netconfig, Xtest);

% 
[~, pred] = max(p, [], 2);
[~, testLabels] = max(ytest, [], 2);
% 
acc = mean(testLabels(:) == pred(:));
fprintf('Test Accuracy: %0.3f%%\n', acc * 100);
save Alcor stackedAETheta outputSize netconfig hiddenSize
%toc;