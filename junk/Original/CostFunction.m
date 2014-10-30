%  Lambda = 0 for No Regularization

function [J, grad] = CostFunction(params, Y, R, Students, Courses, Features, lambda)
%  Collaborative filtering cost function
%  This function returns the cost and gradient for the
%  collaborative filtering problem.

% Unfold the Y and R matrices from parameters
X = reshape(params(1:Courses*Features), Courses, Features);
Theta = reshape(params(Courses*Features+1:end), Students, Features);

            
% Initialization
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

%  X - Courses x Features matrix of movie features
%  Theta - Students x Features matrix of user features
%  Y - Courses x Students matrix of user ratings of movies
%  R - Courses x Students matrix, where R(i, j) = 1 if the 
%      i-th movie was rated by the j-th user
%  X_grad - Courses x Features matrix, containing the 
%      partial derivatives w.r.t. to each element of X
%  Theta_grad - Students x Features matrix, containing the 
%      partial derivatives w.r.t. to each element of Theta

errors = ((X * Theta' - Y) .* R);
squaredErrors = errors .^ 2;

% Calculating Cost
J = ((1 / 2) * sum(squaredErrors(:)));

% Regularizing the cost
J = J + ((lambda / 2) * sum(Theta(:) .^ 2)) + ((lambda / 2) * sum(X(:) .^ 2));

% Calculating Gradient
X_grad = errors * Theta + (lambda .* X);
Theta_grad = errors' * X + (lambda .* Theta);

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end