Please see the Report.pdf also.

EXECTUTION OF CODE
To execute the program, open the main.m file in matlab and run the program.
A GUI window will open. Enter ratings for the courses you have completed and
close the window to continue. See the console for detailed output.

TRAINING DATA
The ratings by students for different courses are stored in 
course-ratings.txt and list of courses is stored in course-list.txt

Course ratings are stored as a matrix of 80x15 dimension.
It corresponds to ratings for 15 courses by 80 users.

RESULTS
In the folder name Statistics, we have added the codes that
we used to compute the evaluation metrics that we have presented 
in our report.

It contains 3 folders, and all three folders have code modified to
give the desired results. Please be patient while running those codes
because unlike the main program, they have to be tested for multiple
values so training the model is done multiple times to generate 
the desired results and thus, it will take some time.

In Precision and Recall folder, a seperate README is provided for 
information on how to run it.

CODE
The file main.m has the main code content. CostFunction.m has the 
objection function, and fmincg.m has the update rule function.
The files f2.m and GUI3.m contain the code for GUI.