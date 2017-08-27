function X = SA2param(state, action)

self = mdp();
X = zeros(length(self.states) * length(self.actions), 1)'; 
X((state - 1) * 4 + action) = 1;

%非线性不行是因为这是线性回归。。
% X = zeros(length(self.states) + length(self.actions), 1)'; 
% X(state) = 1;
% X(length(self.states) + action) = 1;

end

