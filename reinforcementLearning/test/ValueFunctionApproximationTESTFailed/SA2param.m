function X = SA2param(state, action)

self = mdp();
X = zeros(length(self.states) * length(self.actions), 1)'; 
X((state - 1) * 4 + action) = 1;

%�����Բ�������Ϊ�������Իع顣��
% X = zeros(length(self.states) + length(self.actions), 1)'; 
% X(state) = 1;
% X(length(self.states) + action) = 1;

end

