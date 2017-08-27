function Theta = updateSoftmaxPolicy(Theta, state, action, G, alpha)

self = mdp();
actions = self.actions;
X = SA2param(state, action);
prob = policy(state, Theta);

delta_logJ = X;
for a1  = 1 : length(actions)
    X1 = SA2param(state, a1);
    delta_logJ = delta_logJ - X1 * prob(a1);
end
Theta = Theta - alpha * (-delta_logJ) * G;
end