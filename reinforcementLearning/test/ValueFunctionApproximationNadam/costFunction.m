function [J, grad] = costFunction(Theta, X, y)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples

X = [ones(m, 1) X];

grad = 1 / m * X' * (X * Theta - y);

% ============================================================

% Save the cost J in every iteration    
J = 1 / (2 * m) * sum((X * Theta - y) .^ 2);

end
