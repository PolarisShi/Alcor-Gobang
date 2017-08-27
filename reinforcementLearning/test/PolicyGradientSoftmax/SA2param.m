function X = SA2param(state, action)

self = mdp();
X = zeros(length(self.states) * length(self.actions), 1)'; 
X((state - 1) * 4 + action) = 1;

% Ϊʲô��������д�ᵼ�²�ͬ: exp(m + 1) / (exp(m + 1) + exp(m + 2)) ����mȡʲô�����һ��
% X = zeros(length(self.states) + length(self.actions), 1)'; 
% X(state) = 1;
% X(length(self.states) + action) = 1;


X = [1, X];
end

