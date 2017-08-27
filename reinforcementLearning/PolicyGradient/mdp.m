function self = mdp()

% MAP =  [0, 0, 0, 0;
%         0,-1, 0,-1;
%         0, 0, 0,-1;
%        -1, 0, 0, 1];

self.states = [1 : 16]';
self.terminal_states = zeros(16, 1);
self.terminal_states([6, 8, 12, 13, 16]') = 1;

% LEFT = 1;
% DOWN = 2;
% RIGHT = 3;
% UP = 4;
self.actions = [1, 2, 3, 4];

self.rewards = 0 * ones(16, 1);

self.rewards(6) = 0;
self.rewards(8) = 0;
self.rewards(12) = 0;
self.rewards(13) = 0;
self.rewards(16) = 1;

self.trans = zeros(16, 4);
MAP = reshape(self.states, 4, 4)';
for ii = 1 : 4
    for jj = 1 : 4
        if jj == 1
            self.trans(jj + (ii - 1) * 4, 1) = MAP(ii, jj);
        else
            self.trans(jj + (ii - 1) * 4, 1) = MAP(ii, jj) - 1;
        end
        if ii == 4
            self.trans(jj + (ii - 1) * 4, 2) = MAP(ii, jj);
        else
            self.trans(jj + (ii - 1) * 4, 2) = MAP(ii, jj) + 4;
        end
        if jj == 4
            self.trans(jj + (ii - 1) * 4, 3) = MAP(ii, jj);
        else
            self.trans(jj + (ii - 1) * 4, 3) = MAP(ii, jj) + 1;
        end
        if ii == 1
            self.trans(jj + (ii - 1) * 4, 4) = MAP(ii, jj);
        else
            self.trans(jj + (ii - 1) * 4, 4) = MAP(ii, jj) - 4;
        end
    end
end

for ii = 1 : 16
    if self.terminal_states(ii) == 1
        self.trans(ii, :) = ii * ones(1, 4);
    end
end

self.gamma = 0.8;


end
