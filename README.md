# Geting and Cleanning Human Activity Recognition Using Smartphones Data Set

## Introduction:
The goal is to prepare tidy data that can be used for later analysis. 

The data source will be:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

And its explanation could be found:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

## Transformation done by run_analysis.R:
### Load Data Set
Load the *X_train.txt* and *X_test.txt* datasets and bind them together into 1 main dataset

### Select only Mean and Std columns
The meassurements that were representatives for this analysis were all the Means and StdDev. Using regular expressions the script selects only the columns containing that data and creates a **subset** of the original one.

### Labels the data set
As the original labels were too hard to read, using regular expresions the script changes the original names for more readable ones using as input the *features.txt* file. Also, adds to the beggining the words MeanOf, so the final script can contains more representative names.

### Using descriptives activities names
The script pulls out all the activities from the *y_train.txt* and *y_test.txt*. After that it changes the numbers by more understandable names and attach it to the data set in the first position

### Add Subjects and create a tidy data set
After that, the scripts adds the subject column from *subjects_train.txt* and *subjects_test.txt*. Using the **dplyr** package to calculate the average of each variable for each activity and each subject. Finally, the script exports the tidy data to a txt file using write.table.