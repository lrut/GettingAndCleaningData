# Code Book - Course project for Getting and Cleaning Data
This code book describes the variables, the data, and transformations performed to clean up the data.


Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


# Data set information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


# Source data description

The dataset includes the following files:
* "README.txt"
* "features_info.txt": Shows information about the variables used on the feature vector.
* "features.txt": List of all features.
* "activity_labels.txt": Links the class labels with their activity name.
* "train/X_train.txt": Training set.
* "train/y_train.txt": Training labels.
* "test/X_test.txt": Test set.
* "test/y_test.txt": Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.
* "train/subject_train.txt": Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* "train/Inertial Signals/total_acc_x_train.txt": The acceleration signal from the smartphone accelerometer X axis in standard gravity units "g". Every row shows a 128 element vector. The same description applies for the "total_acc_x_train.txt" and "total_acc_z_train.txt" files for the Y and Z axis.
* "train/Inertial Signals/body_acc_x_train.txt": The body acceleration signal obtained by subtracting the gravity from the total acceleration.
* "train/Inertial Signals/body_gyro_x_train.txt": The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Note: Features are normalized and bounded within [-1,1]. Each feature vector is a row on the text file.

# Scipt description
The attached R script (run_analysis.R) performs the following steps in order to cleanse the data set:

## 1. Merges the training and the test sets to create one data set.
It unions the training and test data, i.e. test data is added to the end of training data. This results in three data frames:
* X  contains features itself = 10299 rows and 561 columns, 
* Subject contains subject IDs = 10299 rows and 1 column,
* Y contains activity IDs = 10299 rows and 1 column.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Loads features.txt and extracts only the measurements of the mean and standard deviation. This was based on regular expression searching for mean and std. 
The result is a data frame with 10299 rown and 66 column. 

## 3. Uses descriptive activity names to name the activities in the data set.
This part of the script reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
* walking,
* walkingupstairs,
* walkingdownstairs,
* sitting,
* standing,
* laying.
Underscores are replaced.

## 4. Appropriately labels the data set with descriptive variable names and creates final output file.
The script labels the data set with descriptive names. All feature names are converted to lower case, brackets are replaced. 

Finally, it merges the data frame containing features with activity labels and subject IDs frames. The result is saved as cleansed_data.txt - data frame with 10299 rows and 68 columns.

## 5. Creates a second tidy data set with the average of each variable for each activity and each subject.
The result is saved as second_data.txt - data frame with 180 rows (30 subjects x 6 activities) and 68 columns.
