function p = predict(Theta, X)


m = size(X, 1);

p = [ones(m, 1) X] * Theta;

end