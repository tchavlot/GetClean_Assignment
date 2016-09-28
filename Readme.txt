The run_analysis.R script reads data from the "Human Activity Recognition Using Smartphones Dataset Version 1.0" and produces a 
new - tidy - dataset which may be used for further analysis.

The data in the "Human Activity Recognition Using Smartphones Dataset Version 1.0" have been taken from experiments carried out with a group of 
30 volunteers within an age bracket of 19-48 years. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz data were captured. 
The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Explanation of the code

The first part of the code enables to get all the sources necessary for the analysis : acc_labels, test_db, train_db, subjectTrain, ytrain, subjectTest, ytest
and to do some data cleaning : we reviewed the names of the columns for several datasets.

Once this first step is done, we keep only the variables containing either sd or mean (with the function grep)

Then we merge all the datasets (using cbind, rbind and merge) to get a unique datasets with all the information.

Last but not least we calculate the mean data using melt and dcast.

Thanks for this great exercice !

Marc 