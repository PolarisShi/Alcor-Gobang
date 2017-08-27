function g = sigmoidGradient(z)

% g = sigmoid(z) .* (1 - sigmoid(z));
g = z;
g(z > 0) = 1;
g(z <= 0) = 0.00;

end
