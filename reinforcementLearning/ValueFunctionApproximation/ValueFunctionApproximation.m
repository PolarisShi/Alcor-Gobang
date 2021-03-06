clc, clear;
% 前提：s不可穷举，但a可穷举
% 用nn代替Qtable即可。
self = mdp();
states = self.states;
actions = self.actions;
gamma = self.gamma;
epsilon = 0.5; % 0 < epsilon <= 1
sample_number = 5000;

% nn params
input_layer_size  = 64;
output_layer_size = 1;
initial_Theta = randInitializeWeights(input_layer_size, output_layer_size);
Theta = initial_Theta(:);
alpha = 0.01;



for ii = 1 : sample_number
    
    [sample_state, sample_action, sample_reward] = EpsilonSample(Theta, input_layer_size, output_layer_size, epsilon);
    for step = unidrnd(length(sample_state))%1 : length(sample_state)
        
        state = sample_state(step);
        action = sample_action(step);
        [next_state, reward, dummy2] = transform(state, action);
        
        X = SA2param(state, action);
        Q = predict(Theta, X);
        
        next_Qmax = -10;
        next_action = 1;
        for a1 = 1 : length(actions)
            
            % feed forward
            % f(X) == Q(s,a)
            next_X = SA2param(next_state, a1);
            next_Q = predict(Theta, next_X);%%%%
            
            if next_Qmax < next_Q
                next_Qmax = next_Q;
                next_action = a1;
            end
        end
        
        % back propagation
        X = SA2param(state, action);
        y = reward + gamma * next_Qmax;
        
        [Theta, J] = gradientDescent(X, y, Theta, alpha, 10);
    end
    fprintf('%4i  %4.6e\r', ii, J);
end

Qtable = zeros(length(states), length(actions));
for ii = 1 : length(states)
    for jj = 1 : length(actions)
        X = SA2param(ii, jj);
        Qtable(ii, jj) = predict(Theta, X);
    end
end
[dummy, pi] = max(Qtable, [], 2);
reshape(pi, 4, 4)'