clc, clear;

grid_mdp = mdp;

V = zeros(size(grid_mdp.states, 1), 1);
pi = ones(size(grid_mdp.states, 1), 1);

V_matrix = V;
pi_matrix = [];

for ii = 1 : 10
    delta = 0;
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
        delta = delta + abs(V1 - V(state));
        pi(state) = a1;
        V(state) = V1;
        
    end
    
    if delta < 1e-6
        break;
    end
    
    V_matrix = [V_matrix, V];
    pi_matrix = [pi_matrix, pi];
    
end

