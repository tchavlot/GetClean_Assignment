#import libraries
library(dplyr)
library(data.table)

# I have downloaded the zip file on my computer, but of course it is possible to download and unzip with R
# Import & read the train data
# Import the activity labels (2 variables V1 and V2)
acc_labels <- read.table("C:/Users/MarLacroix/Documents/Marc/Formation/Cours Data Science Hopkins/Getting and cleaning data/Assignment UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
#import the features
features <- read.table("C:/Users/MarLacroix/Documents/Marc/Formation/Cours Data Science Hopkins/Getting and cleaning data/Assignment UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
# Import & read the test data
test_db <- read.table("C:/Users/MarLacroix/Documents/Marc/Formation/Cours Data Science Hopkins/Getting and cleaning data/Assignment UCI HAR Dataset/test/X_test.txt")
test_db <- data.table(test_db)
#import & read the train data
my_directory <- "C:/Users/MarLacroix/Documents/Marc/Formation/Cours Data Science Hopkins/Getting and cleaning data/Assignment UCI HAR Dataset/"
train_db <- read.table(paste(my_directory,"train/X_train.txt",sep = ""))
train_db <- data.table(train_db)

# Rename test_db and train_db variables according to features
names(test_db)[1:561] <-features$V2 [1:561] 
names(train_db)[1:561] <-features$V2 [1:561] 

#import subject_train and y_train 
subtrain_db <- read.table(paste(my_directory,"train/subject_train.txt",sep = ""))
subtrain_db <- data.table(subtrain_db)
ytrain_db <- read.table(paste(my_directory,"train/y_train.txt",sep = ""))
ytrain_db <- data.table(ytrain_db)
names(ytrain_db)[1] = "activity"
names(subtrain_db)[1] = "subject"

#import subject_test and y_test 
subtest_db <- read.table(paste(my_directory,"test/subject_test.txt",sep = ""))
subtest_db <- data.table(subtest_db)
ytest_db <- read.table(paste(my_directory,"test/y_test.txt",sep = ""))
ytest_db <- data.table(ytest_db)
names(ytest_db)[1] = "activity"
names(subtest_db)[1] = "subject"

#keep only the variables containing either sd or mean
#get the number of the columns where mean or std appears
keep_var <- grep(".*mean.*|.*std.*", features$V2)

#we keep only the variables with mean and std in test db
test_db <-test_db[, keep_var, with = FALSE]

#we keep only the variables with mean and std in train db
train_db <-train_db[, keep_var, with = FALSE]

# for each activity add subtrain and ytrain in train_db
#cbind concatenates columns from different tables
train_db <- cbind(train_db,ytrain_db)
train_db <- cbind(train_db,subtrain_db)

# for each activity of test  add subtest and ytest in test_db
#cbind concatenates columns from different tables
test_db <- cbind(test_db,ytest_db)
test_db <- cbind(test_db,subtest_db)

#merge all lignes
merged_db <- rbind(train_db, test_db)

#join with acc_labels to get the activity labels
joined_db <- merge(merged_db,acc_labels, by.x="activity", by.y= "V1", all = TRUE)
joined_db <- arrange(joined_db,activity)
names(joined_db)[82] = "Activity_Label"

#cross table
##Melt the dataset with the descriptive activity names for better handling
data_melt <- melt(joined_db,id=c("subject","activity","Activity_Label"))
mean_data <- dcast(data_melt,activity + Activity_Label + subject ~ variable,mean)
write.table(mean_data,"./tidy_mov_data.txt")
