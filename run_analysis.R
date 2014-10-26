#1. Merges the training and the test sets to create one data set.
#  -----------------------------------
# | Subject | Activity | Measurements |
#  -----------------------------------

data_dir <- "UCI HAR Dataset"

#Load the Training Set
training_set_path <- paste(data_dir,"train","X_train.txt",sep="/")
training_set <- read.table(training_set_path)

#Load Subjects

#Load Activities

#Load the Test Set
test_set_path <- paste(data_dir,"test","X_test.txt",sep="/")
test_set <- read.table(test_set_path)



# Mergin sets into one data set
data_set <- rbind(training_set,test_set)

# Removing unused data
rm(test_set,training_set,training_set_path,test_set_path)


#2. Extracts only the measurements on the mean and standard deviation for each
#measurement. 
features_name <- read.table(paste(data_dir,"features.txt",sep="/"))[,2]
colnames(data_set) <- features_name
selected_measures <- grepl('-(mean|std)\\(',features_name)
data_set <- subset(data_set,select=selected_measures)



#3. Uses descriptive activity names to name the activities in the data set
activities_train_path <- paste(data_dir,"train","y_train.txt",sep="/")
activities_train_set <- read.table(activities_train_path)
activities_test_path <- paste(data_dir,"test","y_test.txt",sep="/")
activities_test_set <- read.table(activities_test_path)
activities <- rbind(activities_train_set,activities_test_set)[,1]
labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                "SITTING", "STANDING", "LAYING")
activities <- labels[activities]
data_set <- cbind(Activity = activities,data_set)

#4. Appropriately labels the data set with descriptive variable names. 
colnames(data_set) <- gsub("mean", "Mean", colnames(data_set))
colnames(data_set) <- gsub("std", "Std", colnames(data_set))
colnames(data_set) <- gsub("^t", "Time", colnames(data_set))
colnames(data_set) <- gsub("^f", "Frequency", colnames(data_set))
colnames(data_set) <- gsub("\\(\\)", "", colnames(data_set))
colnames(data_set) <- gsub("-", "", colnames(data_set))
colnames(data_set) <- gsub("BodyBody", "Body", colnames(data_set))
colnames(data_set)

#5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.