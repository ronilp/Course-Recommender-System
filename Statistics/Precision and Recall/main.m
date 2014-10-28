%  ======== Loading Data ========  %
Y = load('course-ratings.txt'); 
R = logical(Y);

fid = fopen('course-list.txt');
n = 15;  % Total number of courses 
courseList = cell(n, 1);
for i = 1:n
    courseList{i} = strtrim(fgets(fid));
end
fclose(fid);

%  Splitting Data Set
Ytrain = Y(1:56,:);
Rtrain = R(1:56,:);
Ytest = Y(57:80,:);
Rtest = R(57:80,:);

%  ======== Entry for New Student ========  %
%  Before we will train the collaborative filtering model, we will first
%  add ratings that correspond to a the new student who entered his/her
%  ratings.

for std=1:24
    student_rating = Ytest(std,:);
    %  Add new student ratings to the data matrix
    Y = [student_rating Y'];
    R = [(student_rating ~= 0) R'];
    my_predictions = doCalculations(student_rating,Y,R);
    %  Sorting predicted ratings in descending order
    [r, index] = sort(my_predictions, 'descend');
end