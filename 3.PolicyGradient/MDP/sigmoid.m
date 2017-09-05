function g = sigmoid(z)

%g = 1 ./ (1 + exp( - z));
g = z;
g(z <= 0) = 0.00 * g(z <= 0);
end
