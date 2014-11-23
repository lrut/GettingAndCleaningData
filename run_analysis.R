#########################################################
## Name:        Run Analysis
## Description: R scripts for the project assignment
## Created by:  LR
## Date:        2014-11-21
#########################################################

# 0. Preparation
#setwd("03_Data_Cleansing/Project")

## Download and unzip the source files
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, "Dataset.zip")
unzip("Dataset.zip")

## See the files
setwd("UCI HAR Dataset")
list.files(recursive=TRUE)

##################################################################################################
# 1. Merges the training and the test sets to create one data set.

x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
##merge data - add lines
X <- rbind(x_train, x_test)

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
## merge subjects - add lines
Subject <- rbind(subject_train, subject_test)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
## merge labels - add lines
Y <- rbind(y_train, y_test)

##################################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
meanStdDev_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, meanStdDev_features]
names(X) <- features[meanStdDev_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

##################################################################################################
# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

##################################################################################################
# 4. Appropriately labels the data set with descriptive activity names.

names(Subject) <- "subject"
##merger data sets - columns
ready <- cbind(Subject, Y, X)
write.table(ready, "cleansed_data.txt",row.names=FALSE)

##################################################################################################
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
ids <- c("subject", "activity")
measures <- setdiff(colnames(ready), ids)
melt_set = melt(ready, id = ids, measure.vars = measures)
result   = dcast(melt_set, subject + activity ~ variable, mean)

write.table(result, "second_data.txt",row.names=FALSE)