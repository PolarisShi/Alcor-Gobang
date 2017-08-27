clc, clear;

self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;
alpha = 0.01;

[sample_state, sample_action, sample_reward] = sample(2000);

Vfunc = zeros(length(states), 1);

for ii = 1 : size(sample_state, 1)
    for step = 1 : length(sample_state{ii})
        state = sample_state{ii}(step);
        reward = sample_reward{ii}(step);
        
        if length(sample_state{ii}) - 1 > step
            next_state = sample_state{ii}(step + 1);
            next_V = Vfunc(next_state);
        else
            next_V = 0;
        end
        
        Vfunc(state) = Vfunc(state) + alpha * (reward + gamma * next_V - Vfunc(state));
    end
end
reshape(Vfunc, 4, 4)'