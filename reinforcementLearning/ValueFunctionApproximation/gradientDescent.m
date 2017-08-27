function [Theta, J] = gradientDescent(X, y, Theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
X = [ones(m, 1) X];
for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %

    Theta = Theta - alpha / m * X' * (X * Theta - y);

    % ============================================================

    % Save the cost J in every iteration    
    J = 1 / (2 * m) * sum((X * Theta - y) .^ 2);

end

end
