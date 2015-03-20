function [my_predictions] = doCalculations(Y, R, Features,lambda)

%  ======== Training the Model ========  %
fprintf('\nTraining collaborative filtering model\n');

Courses = size(Y,1);
Students = size(Y,2);

%  Randomly Initializing Parameters X and Theta
X = randn(Courses, Features);
Theta = randn(Students, Features);

initial_parameters = [X(:); Theta(:)];
options = optimset('GradObj', 'on', 'MaxIter', 100);
theta = fmincg (@(t)(CostFunction(t, Y, R, Students, Courses, Features, lambda)), initial_parameters, options);

X = reshape(theta(1:Courses*Features), Courses, Features);
Theta = reshape(theta(Courses*Features+1:end), Students, Features);

fprintf('Recommender system learning completed.\n');

%  ======== Giving Recommendations ========  %
p = X * Theta';
my_predictions = p(:,1);

end