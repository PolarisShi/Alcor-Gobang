function [J, grad] = costFunctionReg(Theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(Theta));
X = [ones(m, 1) X];
% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

n = length(Theta);
ServantMatrix = ones(n, 1);
ServantMatrix(1) = 0;

J = - 1 / m * sum(y .* log(sigmoid(X * Theta)) + ...
    (1 - y) .* log(1 - sigmoid(X * Theta))) + ...
    lambda / (2 * m) * sum(ServantMatrix .* Theta .^ 2);

grad = 1 / m * X' * (sigmoid(X * Theta) - y) + ...
    lambda / m * ServantMatrix .* Theta;

% =============================================================

end
