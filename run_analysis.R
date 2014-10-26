#1. Merges the training and the test sets to create one data set.
#  -----------------------------------
# | Subject | Activity | Measurements |
#  -----------------------------------

data_dir <- "UCI HAR Dataset"

file_path <- function(...) { paste(data_dir,...,sep="/") }

#Load the Data Set
training_set <- read.table(file_path("train/X_train.txt"))
test_set <- read.table(file_path("test/X_test.txt"))
data_set <- rbind(training_set,test_set)
data_set[1:4,1:5]

# Removing unused data
rm(test_set,training_set)


#2. Extracts only the measurements on the mean and standard deviation for each
#measurement. 
features_name <- read.table(file_path("features.txt"))[,2]
colnames(data_set) <- features_name
selected_measures <- grepl('-(mean|std)\\(',features_name)
data_set <- subset(data_set,select=selected_measures)
data_set[1:4,1:5]


#3. Uses descriptive activity names to name the activities in the data set
activities_train <- read.table(file_path("train/y_train.txt"))
activities_test <- read.table(file_path("test/y_test.txt"))
activities <- rbind(activities_train,activities_test)[,1]
labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                "SITTING", "STANDING", "LAYING")
activities <- labels[activities]
data_set <- cbind(Activity = activities,data_set)
data_set[1:4,1:5]

#4. Appropriately labels the data set with descriptive variable names. 
colnames(data_set) <- gsub("mean", "Mean", colnames(data_set))
colnames(data_set) <- gsub("std", "Std", colnames(data_set))
colnames(data_set) <- gsub("^t", "Time", colnames(data_set))
colnames(data_set) <- gsub("^f", "Frequency", colnames(data_set))
colnames(data_set) <- gsub("\\(\\)", "", colnames(data_set))
colnames(data_set) <- gsub("-", "", colnames(data_set))
colnames(data_set) <- gsub("BodyBody", "Body", colnames(data_set))
colnames(data_set)
data_set[1:4,1:5]


#5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
subjects_train <- read.table(file_path("train/subject_train.txt"))
subjects_test <- read.table(file_path("test/subject_test.txt"))
subjects <- rbind(subjects_train,subjects_test)[,1]
data_set <- cbind(Subject = subjects,data_set)
data_set[1:4,1:5]

library('dplyr')
average_data_set <- data_set %>%
                        group_by(Subject,Activity) %>%
                        summarise_each(funs(mean))

write.table(average_data_set,row.name = FALSE,file = "tidy_data_set.txt")