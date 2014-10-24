## Author: Melvin Yap

library(dplyr)

#1. Merges the training and the test sets to create one data set.

## Read and merge training files, merging feature signal measurements (xTrain) 
## with volunteer subjects (subjectTrain) and finally the activity (yTrain).
subjectTrain <- read.table("./UCI Har Dataset/train/subject_train.txt")
xTrain <- read.table("./UCI Har Dataset/train/X_train.txt")
yTrain <- read.table("./UCI Har Dataset/train/y_train.txt")
train <- cbind(cbind(xTrain, subjectTrain), yTrain)

## Read and merge testing files in the same way as training files.
subjectTest <- read.table("./UCI Har Dataset/test/subject_test.txt")
xTest <- read.table("./UCI Har Dataset/test/X_test.txt")
yTest <- read.table("./UCI Har Dataset/test/y_test.txt")
test <- cbind(cbind(xTest, subjectTest), yTest)

## Merge training and testing data
merged <- rbind(train,test)

#2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement.

## Read features file
features <- read.table("./UCI Har Dataset/features.txt")

## Identify features that contains mean (mean()) and standard deviation (std()).
## Refer to features_info.txt
featuresWithMeanStd <- filter(features, grepl("mean\\(\\)|std\\(\\)", 
                                              features[,2]))

## Remove all brackets and hyphens to prevent problems referencing the features
## as column names. In addition, ensure feature name is camel-cased.
featuresWithMeanStd <- cbind(featuresWithMeanStd[,1],
                             sub("-mean\\(\\)", "Mean", 
                                 featuresWithMeanStd[,2]))
featuresWithMeanStd <- cbind(featuresWithMeanStd[,1],
                             sub("-std\\(\\)", "Std", 
                                 featuresWithMeanStd[,2]))
featuresWithMeanStd <- cbind(featuresWithMeanStd[,1],
                             sub("-", "", 
                                 featuresWithMeanStd[,2]))

## Extract only mean and std deviation measurements in the dataset and apply
## column names to them as preparation for subsequent tasks of the course
## project.
mergedWithMeanStd <- merged[,c(as.numeric(featuresWithMeanStd[,1]),
                               length(merged)-1, length(merged))]
names(mergedWithMeanStd) <- c(featuresWithMeanStd[,2], "volunteerID", 
                              "activity")

#3. Uses descriptive activity names to name the activities in the data set.

## Read activity labels file
activities <- read.table("./UCI Har Dataset/activity_labels.txt")

## Derive descriptive activity names to apply to dataset. Activity value is
## dropped after that.
resultData <- mergedWithMeanStd %>% 
    mutate(activityName=activities[activity,2]) %>% 
    select(-activity)

#4. Appropriately labels the data set with descriptive variable names.
## Done in Line 49 of this R script.

#5.From the data set in step 4, creates a second, independent tidy data set 
#  with the average of each variable for each activity and each subject.
tidyData <- resultData %>% 
    group_by(volunteerID, activityName) %>% 
    summarise_each(funs(mean))
write.table(tidyData, "TidyDataset.txt", row.names=FALSE)
