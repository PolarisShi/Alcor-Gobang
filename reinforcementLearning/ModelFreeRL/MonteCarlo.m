clc, clear;

self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;

[sample_state, sample_action, sample_reward] = sample(2000);

Vfunc = zeros(length(states), 1);
nfunc = zeros(length(states), 1);

for ii = 1 : size(sample_state, 1)
    G = 0;
    for step = length(sample_state{ii}) : -1 : 1
        G = G * gamma;
        G = G + sample_reward{ii}(step);
        state = sample_state{ii}(step);
        Vfunc(state) = Vfunc(state) + G;
        nfunc(state) = nfunc(state) + 1.0;
    end
end

for state = 1 : length(states)
    if nfunc(state) > 1e-6
        Vfunc(state) = Vfunc(state) / nfunc(state);
    end
end
reshape(Vfunc, 4, 4)'
        