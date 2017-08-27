clc, clear;

% 前提：s不可穷举，但a可穷举
% 用nn代替Qtable即可。
self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;

epsilon = 0.5; % 0 < epsilon <= 1
sample_number = 20000;

alpha = 0.01;

%%
Theta = randInitializeWeights(length(states) * length(actions), 1);

for ii = 1 : sample_number
    ii
    G = 0;
    [sample_state, sample_action, sample_reward] = EpsilonSample(Theta, epsilon);
    
    for step = length(sample_state) : -1 : 1
        G = G * gamma;
        G = G + sample_reward(step);
        state = sample_state(step);
        action = sample_action(step);
        
        Theta = updateSoftmaxPolicy(Theta, state, action, G, alpha);
        
    end
    %fprintf('%4i  %4.6e\r', ii, cost);
end


Qtable = zeros(length(states), length(actions));
for state = 1 : length(states)
    X = zeros(1, length(self.states));
    X(state) = 1;

    Qtable(state, :) =  policy(state, Theta);
    
end
[dummy, pi] = max(Qtable, [], 2);
reshape(pi, 4, 4)'