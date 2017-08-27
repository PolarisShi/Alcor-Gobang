clc, clear;

self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;
alpha = 0.01;
epsilon = 0.9; % 0 < epsilon <= 1
sample_number = 2000;

Q = zeros(length(states), length(actions)); % Q 近似等价于 V

for ii = 1 : sample_number
    G = 0;
    [sample_state, sample_action, sample_reward] = EpsilonSample(Q, epsilon);
    for step = 1 : length(sample_state)
        
        state = sample_state(step);
        action = sample_action(step);
        
        [next_state, dummy1, dummy2] = transform(state, action);
        
        [dummy, greedy_actions] = max(Q(next_state, :), [], 2);
        
        Q(state, action) = Q(state, action) + alpha * (sample_reward(step) + gamma * Q(next_state, greedy_actions) - Q(state, action));
        
    end
end

[dummy, pi] = max(Q, [], 2);
reshape(pi, 4, 4)'