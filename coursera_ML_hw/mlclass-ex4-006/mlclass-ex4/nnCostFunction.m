function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
% Theta1_grad = zeros(size(Theta1));
% Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
yk = zeros(m, num_labels);
yk = yk';
yk((0:(m-1))*size(yk,1)+y') = 1;
yk = yk';

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
hyp = h2;

theta1 = Theta1;
theta2 = Theta2;
theta1(:,1) = 0;
theta2(:,1) = 0;

J = sum(sum(-1/m * (log(hyp).*yk+log(1.-hyp).*(1-yk))))+lambda/(2*m)*(sum(sum(theta1.*theta1))+sum(sum(theta2.*theta2)));
 
% Back Propagation

a1 = zeros(1, input_layer_size+1);
z2 = zeros(1, hidden_layer_size);
a2 = zeros(1, hidden_layer_size+1);
z3 = zeros(1, num_labels);
a3 = zeros(1, num_labels);
delta2 = zeros(1, hidden_layer_size);
delta3 = zeros(1, num_labels);
Theta1_grad = zeros(hidden_layer_size, input_layer_size+1);
Theta2_grad = zeros(num_labels, hidden_layer_size+1);
for t=1:m
    a1 = [1 X(t,:)];
    z2 = a1 * Theta1';
    a2 = sigmoid(z2);
    a2 = [1 a2];
    z3 = a2 * Theta2';
    a3 = sigmoid(z3);
    delta3 = a3 - yk(t,:);
    delta2 = delta3 * Theta2(:, 2:end).* ( sigmoid(z2).* (1-sigmoid(z2)) );
    Theta1_grad = Theta1_grad + delta2' * a1;
    Theta2_grad = Theta2_grad + delta3' * a2;
end

Theta1_grad = 1/m * (Theta1_grad) + lambda/m * theta1;
Theta2_grad = 1/m * (Theta2_grad) + lambda/m * theta2;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
