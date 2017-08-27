clc, clear;

self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;
epsilon = 0.9; % 0 < epsilon <= 1
sample_number = 2000;

Q = zeros(length(states), length(actions)); % Q 近似等价于 V
n = zeros(length(states), length(actions));

for ii = 1 : sample_number
    G = 0;
    [sample_state, sample_action, sample_reward] = EpsilonSample(Q, epsilon);
    for step = length(sample_state) : -1 : 1
        
        G = G * gamma;
        G = G + sample_reward(step);
        state = sample_state(step);
        action = sample_action(step);
        
        Q(state, action) = (Q(state, action) * n(state, action) + G) / (n(state, action) + 1);
        n(state, action) = n(state, action) + 1;
        
    end
end

[dummy, pi] = max(Q, [], 2);
reshape(pi, 4, 4)'