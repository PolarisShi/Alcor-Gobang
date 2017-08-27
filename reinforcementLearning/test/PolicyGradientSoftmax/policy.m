function prob = policy(state, Theta)

self = mdp();
actions = self.actions;

prob = zeros(1, length(actions));
sum_prob = 0;
for action = 1 : length(actions)
    X = SA2param(state, action);
    
    prob(action) = exp(X * Theta'); %%%重点！！！可以改成MNN
    sum_prob = sum_prob + prob(action);
end
prob = prob / sum_prob;
end