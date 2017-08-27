function [sample_state, sample_action, sample_reward] = sample(num_of_sample)

sample_state = {};
sample_action ={};
sample_reward = {};
self = mdp();

for ii = 1 : num_of_sample
    
    tmp_state = [];
    tmp_action = [];
    tmp_reward = [];
    
    % prevent terminal states
    for k1 = 1 : 1000
        rand_state = unidrnd(length(self.states));
        if self.terminal_states(rand_state) == 1
            continue;
        else
            break;
        end
    end
    
    tmp_state = [tmp_state, rand_state];
    
    for k2 = 1 : 1000
        rand_action = unidrnd(length(self.actions));
        tmp_action = [tmp_action, rand_action];
        [next_state, reward, done] = transform(tmp_state(end), tmp_action(end));
        tmp_reward = [tmp_reward, reward];
        if done == 1
            break;
        else
            tmp_state = [tmp_state, next_state];
        end
    end
    sample_state = [sample_state; tmp_state];
    sample_action = [sample_action; tmp_action];
    sample_reward = [sample_reward; tmp_reward];
end
            
        