clc, clear;

grid_mdp = mdp;

V = zeros(size(grid_mdp.states, 1), 1);
pi = ones(size(grid_mdp.states, 1), 1);

for ii = 1 : 10
    
    % policy evaluate
    for jj = 1 : 1000
        delta = 0;
        for state = 1 : size(grid_mdp.states, 1)
            if grid_mdp.terminal_states(state) == 1
                continue;
            end
            action = pi(state);
            [next_state, reward, done] = transform(state, action);
            new_V = reward + grid_mdp.gamma * V(next_state);
            delta = delta + abs(new_V - V(state));
            V(state) = new_V;
        end
        if delta < 1e-6
            break;
        end
    end
    
    
    % policy improve
    Delta = 0;
    for state = 1 : size(grid_mdp.states, 1)
        if grid_mdp.terminal_states(state) == 1
            continue;
        end
        a1 = grid_mdp.actions(1);
        [next_state, reward, done] = transform(state, a1);
        V1 = reward + grid_mdp.gamma * V(next_state);
        for action = 1 : size(grid_mdp.actions, 2)
            [next_state, reward, done] = transform(state, action);
            if V1 < reward + grid_mdp.gamma * V(next_state)
                a1 = action;
                V1 = reward + grid_mdp.gamma * V(next_state);
            end
        end
        
        Delta = Delta + abs(a1 - pi(state));
        pi(state) = a1;
        
    end
    if Delta < 1e-6
        break;
    end
end