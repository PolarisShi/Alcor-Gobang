function nn_params = initializeParameters(hidden_layer_size, input_layer_size)

r  = sqrt(6) / sqrt(hidden_layer_size + input_layer_size + 1);   % we'll choose weights uniformly from the interval [-r, r]
W1 = rand(hidden_layer_size, input_layer_size) * 2 * r - r;
W2 = rand(input_layer_size, hidden_layer_size) * 2 * r - r;

b1 = zeros(hidden_layer_size, 1);
b2 = zeros(input_layer_size, 1);

nn_params = [W1(:) ; W2(:) ; b1(:) ; b2(:)];

end

