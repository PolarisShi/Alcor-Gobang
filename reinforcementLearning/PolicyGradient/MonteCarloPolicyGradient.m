clc, clear;
addpath deepLearningWithoutPreTraining/
% 前提：s不可穷举，但a可穷举
% 用nn代替Qtable即可。
self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;

epsilon = 1; % 0 < epsilon <= 1
sample_number = 200;

alpha = 0.01;
beta1 = 0.99;
beta2 = 0.999;
epsilonNadam = 1e-8;
lambda = 3e-3;
num_iters = 50;


inputSize  = 16;%length(states);
hiddenSize = [5];
outputSize = length(actions);
num_labels = outputSize;

%% Train the sparse autoencoders

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

%%
for k = 1 : 10
    k
    G = [];
    X = [];
    Y = [];
    for ii = 1 : sample_number
        g = 0;
        [sample_state, sample_action, sample_reward] = EpsilonSample(stackedAETheta, hiddenSize(end), ...
                                                                     outputSize, netconfig, epsilon);
        for step = length(sample_state) : -1 : 1
            g = g * gamma;
            g = g + sample_reward(step);
            G = [G; g];
            state = sample_state(step);
            action = sample_action(step);
            x = S2param(state);
            a = zeros(1, length(actions));
            a(action) = 1;
            y = a;
            X = [X; x];
            Y = [Y; y];
        end
    end
    [stackedAETheta, cost] = stackminiBatchNadam(stackedAETheta, alpha, beta1, beta2, epsilonNadam, num_iters, ...
                                                 hiddenSize, outputSize, netconfig, lambda, X, Y, G);
    epsilon = epsilon - 0.1;
    
end
%%
Qtable = zeros(length(states), length(actions));
for state = 1 : length(states)
    XX = S2param(state);
    Qtable(state, :) = stackedAEPredict(stackedAETheta, hiddenSize(end), ...
                                        outputSize, netconfig, XX);
end
[dummy, pi] = max(Qtable, [], 2);
reshape(pi, 4, 4)'