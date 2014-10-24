Created By: Melvin Yap

---
# Readme
## Setting Up the Working Directory
The following are the steps required to ensure that the _**run_analysis.R**_ script executes successfully:

1. In R Studio, set up your working directory to run the *run_analysis.R* script using the ``setwd()`` function. For e.g.:
```R
setwd("/Users/melvinyap/Documents/melvinyap/Peer Assessment")
```

2. Download the *run_analysis.R* script from the [*GettingCleaningDataProject* GitHub Repository](https://github.com/melvinyap/GettingCleaningDataProject/blob/master/run_analysis.R) into the working directory.

3. Download the zip file from the following URL link as referred by the project specifications:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]()

4. Extract the zip file into the working directory. Ensure that the _**UCI HAR Dataset**_ folder is created and contains the data files.

5. Install the _**dplyr**_ package in R studio.

## Data Files Used
The following data files in the *UCI HAR Dataset* folder are used in the *run_analysis.R* script:

Data File | Purpose 
:--- | :--- 
activity_labels.txt | Code table used to replace the activity code with its descriptive activity name. 
features.txt | Used to identify features that contains mean and standard deviation. Their respective column indexes are used to filter the data frame columns as per the project requirements. 
subject_test.txt | Contains volunteer subject IDs that are used to merge with the testing data. 
subject_train.txt | Contains volunteer subject IDs that are used to merge with the training data. 
X_test.txt | Testing data of feature signal measurements in the *test* folder used for analysis. 
X_train.txt | Training data of feature signal measurements in the *train* folder used for analysis. 
y_test.txt | Testing activity codes in the *test* folder that is used to merge with the testing data. 
y_train.txt | Training activity codes in the *train* folder that is used to merge with the training data. 

## Explanation of *run_analysis.R*

*dplyr* package is installed and referenced in this script. The following is the algorithm explaining how the *run_analysis.R* script works:

###Merging the training and test sets to create one data set.

1. Read and merge training feature signal measurements, volunteer subjects and activities by columns using ``cbind()`` function.

2. Read and merge testing feature signal measurements, volunteer subjects and activities in the same way as (i).

3. Merge training and testing data using ``rbind()`` function.

###Extracting only the measurements on the mean and standard deviation for each measurement.

1. Read the *features.txt* file.

2. Identify features that contains mean and standard deviation using regex expression as parameter in the ``grepl()`` function.

3. Remove all brackets and hyphens in the original variable names so that there will not be any errors when referencing them in the script. The updated variable names and their naming convention are further described in the [Code Book](https://github.com/melvinyap/GettingCleaningDataProject/blob/master/CodeBook.md). (This step will address Part 4 of the project requirements)

###Using descriptive activity names to name the activities in the data set.

1. Read the *activity_labels.txt* file.

2. Derive descriptive activity names to apply to data set. After which, the activity codes are then dropped from the data set.

###Creating a second independent tidy data set with the average of each variable for each activity and each subject

1. Aggregate the resultant data set by taking the mean of the frequency measurement of each variable, grouped by the volunteer subject and activity.
