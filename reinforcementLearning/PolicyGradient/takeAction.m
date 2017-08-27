function action = takeAction(theta, lastHiddenSize, ...
                             outputSize, netconfig, X)

self = mdp();
actions = self.actions;

prob = stackedAEPredict(theta, lastHiddenSize, ...
                        outputSize, netconfig, X);
r = rand();
s = 0;
for action = 1 : length(actions)
    s = s + prob(action);
    if s >= r
        break;
    end
end