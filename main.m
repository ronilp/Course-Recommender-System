%  ======== Loading Data ========  %
Y = load('course-ratings.txt');

%  Y is a 15x80 matrix, containing ratings (1-10) of 15 courses on 
%  80 students.
%  Courses which are not rated by a particular student are given a rating
%  of 0.

%  Converting R to logical matrix
R = logical(Y);

%  R is a 15x80 matrix, where R(i,j) = 1 if student j gave a
%  rating to course i.

%  Average Rating for each of the courses
Avg = sum(Y,1)./sum(Y~=0,1);
course_index = [1:1:size(Y,2)];

%  ======= Visualizing the data =======  %
figure('name','Average ratings for courses');

bar(course_index,Avg);
ylim([0 10]);

ylabel('Average Rating');
xlabel('Course Index');

%  Loading list of courses
fid = fopen('course-list.txt');

%  Storing all courses in cell array courseList{}
n = 15;  % Total number of courses 

courseList = cell(n, 1);
for i = 1:n
    % Read line
    courseList{i} = strtrim(fgets(fid));
end
fclose(fid);

%  ======== Entry for New Student ========  %
%  Before we will train the collaborative filtering model, we will first
%  add ratings that correspond to a the new student who entered his/her
%  ratings.

%  Getting new student's ratings from GUI
s=cell(1,15);
[s{1} s{2} s{3} s{4} s{5} s{6} s{7} s{8} s{9} s{10} s{11} s{12} s{13} s{14} s{15}]=f2(courseList{1},courseList{2},courseList{3},courseList{4},courseList{5},courseList{6},courseList{7},courseList{8},courseList{9},courseList{10},courseList{11},courseList{12},courseList{13},courseList{14},courseList{15});
student_rating = cell2mat(s);

rated_index = [];
for i=1:15
    if student_rating(i) ~=0
        rated_index = [rated_index i];
    end
end

%fprintf('New Student ratings:\n');
%for i = 1:length(student_rating)
%    if student_rating(i) > 0 
%       fprintf('Rated %d for %s\n', student_rating(i), courseList{i});
%    end
%end

%  ======== Training the Model ========  %
%  Now, we will train the collaborative filtering model on a course rating 
%  dataset of 15 courses and 80 students

fprintf('\nTraining collaborative filtering model\n');

%  Add new student ratings to the data matrix
student_rating=student_rating';
Y = [student_rating Y'];
R = [(student_rating ~= 0) R'];


%  ======== Feature Extraction ========  %
%  Number of students = 80, Num of courses = 15. We assume 9 features
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

%  Sorting predicted ratings in descending order
[r, index] = sort(my_predictions, 'descend');

fprintf('\nYour ratings :-\n');
for i = 1:length(student_rating)
    if student_rating(i) > 0 
        fprintf('Rated %d for %s\n', student_rating(i), courseList{i});
    end
end

fprintf('\nCourses you may like :-\n');
for i=1:3
    j = index(i);
    fprintf('Predicted rating %.1f : %s\n', my_predictions(j), courseList{j});
end

%  Displaying output on GUI
GUI3(my_predictions(index(1)), courseList(index(1)),my_predictions(index(2)), courseList(index(2)),my_predictions(index(3)), courseList(index(3)));