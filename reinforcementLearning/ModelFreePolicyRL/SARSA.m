clc, clear;

self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;
alpha = 0.01;
epsilon = 0.9; % 0 < epsilon <= 1
sample_number = 2000;

Q = zeros(length(states), length(actions)); % Q ���Ƶȼ��� V

for ii = 1 : sample_number
    G = 0;
    [sample_state, sample_action, sample_reward] = EpsilonSample(Q, epsilon);
    for step = 1 : length(sample_state)
        
        state = sample_state(step);
        action = sample_action(step);
        
        [next_state, dummy1, dummy2] = transform(state, action);
        
        
        
        if self.terminal_states(next_state) == 1
            Q(state, action) = Q(state, action) + alpha * (sample_reward(step) + gamma * Q(next_state, 1) - Q(state, action));
        else
            s1 = sample_state(step + 1);
            a1 = sample_action(step + 1);
            Q(state, action) = Q(state, action) + alpha * (sample_reward(step) + gamma * Q(s1, a1) - Q(state, action));
        end
        
    end
end

[dummy, pi] = max(Q, [], 2);
reshape(pi, 4, 4)'