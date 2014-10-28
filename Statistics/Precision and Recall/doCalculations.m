function my_predictions = doCalculations(student_rating,Y,R)

rated_index = [];
for i=1:15
    if student_rating(i) ~=0
        rated_index = [rated_index i];
    end
end

%  ======== Training the Model ========  %
%  Now, we will train the collaborative filtering model on a course rating 
%  dataset of 15 courses and 56 students (70% training set)

fprintf('\nTraining collaborative filtering model\n');


%  ======== Feature Extraction ========  %
%  Number of students = 56, Num of courses = 15. We assume 9 features
%  are present as it gives the best accuracy(calcuation shown in the folder
%  name Statistics).

Courses = size(Y,1);
Students = size(Y,2);
Features = 9;   

%  Randomly Initializing Parameters X and Theta
X = randn(Courses, Features);
Theta = randn(Students, Features);

%  To pass X and Theta in fmicg function, we need to unroll them
%  and pass them as a vector. So, we are creating a vector
%  initial_parameter
initial_parameters = [X(:); Theta(:)];

%  Setting options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

%  Setting Regularization Parameter lambda
lambda = 3.2;
theta = fmincg (@(t)(CostFunction(t, Y, R, Students, Courses, Features, lambda)), initial_parameters, options);

%  Unfolding the returned theta vector into X and Theta
X = reshape(theta(1:Courses*Features), Courses, Features);
Theta = reshape(theta(Courses*Features+1:end), Students, Features);

fprintf('Recommender system learning completed.\n');

%  ======== Giving Recommendations ========  %
%  After training the model, we will now predict the ratings for the
%  courses that the student has not done yet. Then we will sort the
%  predicted ratings in descending order and recommend the top 3 rated
%  courses.

p = X * Theta';
my_predictions = p(:,1);

%  Removing already completed courses
for i = 1:length(rated_index)
    course = rated_index(i);
    my_predictions(course) = 0;
end

end