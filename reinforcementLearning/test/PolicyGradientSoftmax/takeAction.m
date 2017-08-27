function action = takeAction(state, Theta)

self = mdp();
actions = self.actions;

prob = policy(state, Theta);
r = rand();
s = 0;
for action = 1 : length(actions)
    s = s + prob(action);
    if s >= r
        break;
    end
end
