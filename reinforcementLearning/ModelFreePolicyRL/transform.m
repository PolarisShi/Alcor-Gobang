function [next_state, reward, done] = transform(state, action)
self = mdp;
if self.terminal_states(state) == 1
    next_state = state;
    reward = 0; %%%可能有问题
    done = 1;
else
    next_state = self.trans(state, action);
    reward = self.rewards(next_state);
    if self.terminal_states(next_state) == 1
        done = 1;
    else
        done = 0;
    end
end