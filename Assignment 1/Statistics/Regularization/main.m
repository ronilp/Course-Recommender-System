%  ======== Loading Data ========  %
Y = load('course-ratings.txt'); 
R = logical(Y);

%  Loading list of courses
fid = fopen('course-list.txt');
n = 15;
courseList = cell(n, 1);
for i = 1:n
    courseList{i} = strtrim(fgets(fid));
end
fclose(fid);

% Vector to store RMS Error with varying number of features
RMSE = [];

%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,0);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

figure('name','With and Without Regularization');
features = [1:1:15];
subplot(2,2,1);
plot(features,RMSE);
hold on;
plot(features,RMSE,'rx','MarkerSize',10);

RMSE = [];

% Regularization
%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,10);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
plot(features,RMSE,'r-');
hold on;
plot(features,RMSE,'bx','MarkerSize',10);
xlabel('Student 1');

% 2nd time
% Vector to store RMS Error with varying number of features
RMSE = [];

%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,0);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
subplot(2,2,2);
plot(features,RMSE);
hold on;
plot(features,RMSE,'rx','MarkerSize',10);

RMSE = [];

% Regularization
%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,10);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
plot(features,RMSE,'r-');
hold on;
plot(features,RMSE,'bx','MarkerSize',10);
xlabel('Student 2');

% 3rd time
% Vector to store RMS Error with varying number of features
RMSE = [];

%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,0);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
subplot(2,2,3);
plot(features,RMSE);
hold on;
plot(features,RMSE,'rx','MarkerSize',10);

RMSE = [];

% Regularization
%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,10);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
plot(features,RMSE,'r-');
hold on;
plot(features,RMSE,'bx','MarkerSize',10);
xlabel('Student 3');

% 4th time
% Vector to store RMS Error with varying number of features
RMSE = [];

%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,0);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
subplot(2,2,4);
plot(features,RMSE);
hold on;
plot(features,RMSE,'rx','MarkerSize',10);

RMSE = [];

% Regularization
%  ======== Calculating RMS Error ========  %
for i=1:15
    my_predictions = doCalculations(Y,R,i,10);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

features = [1:1:15];
plot(features,RMSE,'r-');
hold on;
plot(features,RMSE,'bx','MarkerSize',10);
xlabel('Student 4');