function X = SA2param(state, action)

self = mdp();
X = zeros(length(self.states) * length(self.actions), 1)'; 
X((state - 1) * 4 + action) = 1;

% 为什么下面这样写会导致不同: exp(m + 1) / (exp(m + 1) + exp(m + 2)) 不论m取什么结果都一样
% X = zeros(length(self.states) + length(self.actions), 1)'; 
% X(state) = 1;
% X(length(self.states) + action) = 1;


X = [1, X];
end

