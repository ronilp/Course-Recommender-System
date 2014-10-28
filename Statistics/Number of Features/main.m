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
    my_predictions = doCalculations(Y,R,i);
    RMSE = [RMSE rms(my_predictions - Y(:,1))];
end

figure('name','RMS Errors for different number of features');
features = [1:1:15];
plot(features,RMSE);
hold on;
plot(features,RMSE,'rx','MarkerSize',10);
ylabel('RMS Error');
xlabel('Number of Features');