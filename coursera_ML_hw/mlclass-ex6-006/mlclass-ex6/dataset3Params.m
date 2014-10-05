function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
C_vec = [0.01 0.03 0.1 0.3 1 3 10 30];
sigma_vec = [0.01 0.03 0.1 0.3 1 3 10 30];

x1 = [1 2 1]; 
x2 = [0 4 -1];
min_error = mean(double((1.-yval) ~= yval));

for i = 1:8
    for j = 1:8
        c = C_vec(i);
        sig = sigma_vec(j);
        model= svmTrain(X, y, c, @(x1, x2) gaussianKernel(x1, x2, sig));
        pre = svmPredict(model, Xval);
        error = mean(double(pre ~= yval));
        if min_error>error
            min_error = error;
            C = c;
            sigma = sig;
        end
    end
end





% =========================================================================

end
