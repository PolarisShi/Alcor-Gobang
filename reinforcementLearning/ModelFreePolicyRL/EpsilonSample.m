function [sample_state, sample_action, sample_reward] = EpsilonSample(Q, epsilon)

self = mdp();

sample_state = [];
sample_action = [];
sample_reward = [];

% prevent terminal states
for k1 = 1 : 1000
    rand_state = unidrnd(length(self.states));
    if self.terminal_states(rand_state) == 1
        continue;
    else
        break;
    end
end

sample_state = [sample_state, rand_state];

for k2 = 1 : 1000
    % greedy policy
    if rand > epsilon
        [dummy, greedy_actions] = max(Q, [], 2);
        sample_action = [sample_action, greedy_actions(sample_state(end))];
    else % random
        rand_action = unidrnd(length(self.actions));
        sample_action = [sample_action, rand_action];
    end

    [next_state, reward, done] = transform(sample_state(end), sample_action(end));
    sample_reward = [sample_reward, reward];
    if done == 1
        break;
    else
        sample_state = [sample_state, next_state];
    end
end
