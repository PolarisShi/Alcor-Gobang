clc, clear;
addpath deepLearningWithoutPreTraining/
addpath MDP/
% 前提：s不可穷举，但a可穷举
% 用nn代替Qtable即可。

gamma = 0.6;

epsilon = 0.090; % 0 < epsilon <= 1
sample_number = 500;

alpha = 0.001;
beta1 = 0.99;
beta2 = 0.999;
epsilonNadam = 1e-8;
lambda = 3e-3;
num_iters = 10;

load Alcor
inputSize  = netconfig.inputsize;
num_labels = outputSize;

%%
for k = 1 : 100
    
    GG = [];
    X = [];
    Y = [];
    for ii = 1 : sample_number
        
        k
        ii
        
        g = 0;
        [sample_state, sample_action, sample_reward] = EpsilonSample(stackedAETheta, hiddenSize(end), ...
                                                                     outputSize, netconfig, epsilon);
        G = [];
        for step = length(sample_reward) : -1 : 1
            g = g * gamma;
            g = g + sample_reward(step);
            G = [g; G];
        end
        GG = [GG; G];
        X = [X; sample_state];
        Y = [Y; sample_action];
        
    end
    [stackedAETheta, cost] = stackminiBatchNadam(stackedAETheta, alpha, beta1, beta2, epsilonNadam, num_iters, ...
                                                 hiddenSize, outputSize, netconfig, lambda, X, Y, GG);
    save AlcorNew stackedAETheta outputSize netconfig hiddenSize
end



