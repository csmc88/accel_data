CodeBook for tidy.txt
=====================

This document describes the output table of run_analysis.R which is displayed in console after running the script and also saved in a file named 'tidy.txt'. The following sections include

   * __Data Description__ : Provide insight to the origin of the dataset as well as a brief description on how it should be interpreted.
   * __Variable Description__ : Provide column name explanations and descriptions.
   * __Transformations Applied__ : Provide the list of transformations applied to the original raw data.
   
   
   
Data Description
----------------

   The data is obtained after running run_analysis.R given that the [Samsung Accelerometer Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has been succesfully downloaded and unzipped as the [README](https://github.com/csmc88/accel_data/blob/master/README.md) suggests to do so. Data is composed of Accelerometer and Gyroscope measurements on dimensions X, Y and Z. No specific units are disclosed.
   
   The experiment the data was obtained from consists on 30 subjects performing 6 different tasks and being measured using accelerometer measurements to study their behaviour. The original data collected consisted on 563 columns and 10299 rows divided along 6 files with specific purposes. More information on the README.txt within the Samsung Data.  
   
   The tidy data describes the average values of a subset of the original variables for each combination of activity and subject observed and evaluated. It consists on 68 columns and 180 rows. The values contained in the table are the calculated average of each subset, which refer the mean or standard deviation of another variable.
   

Variable Description
--------------------

   The features selected for this dataset come from accelerometer and gyroscope measurements. The following list explains column name constructs depending on measurement unit and origin.
   
   * `t` ~ Prefix that denotes time. 
   * `f` ~ Prefix that denotes frequency domain signals (After applying fast fourier transform)
   * `X/Y/Z` ~ Suffix that specifies the dimension of measurement.
   * `Acc` ~ Accelerometer signal measurement.
   * `Body` ~ Measurement signal of Body.
   * `Gravity` ~ Measurement signal of Gravity.
   * `Jerk`~ Derivation of Acceleration and Angular Velocity.
   * `Mag` ~ Magnitude of signal calculated with Euclidean norm. No need of letter suffix.
   * `Gyro` ~ Gyroscope measurement signal.
   * `mean` ~ Measurement is the mean of the described observations.  
   * `std` ~ Measurement is the Standard Deviation of the described observations.
   
   Additionally two columns are added
   
   * `activity` ~ Measured activity descriptive name.
   * `subjectID` ~ Subject that performed the measured activity.
   
   The columns included in the datased are included in the following list and should be interpreted using the previous explanations.
   
   * activity
   * subjectID
   * tBodyAcc.mean.X
   * tBodyAcc.mean.Y
   * tBodyAcc.mean.Z
   * tBodyAcc.std.X
   * tBodyAcc.std.Y
   * tBodyAcc.std.Z
   * tGravityAcc.mean.X
   * tGravityAcc.mean.Y
   * tGravityAcc.mean.Z
   * tGravityAcc.std.X
   * tGravityAcc.std.Y
   * tGravityAcc.std.Z
   * tBodyAccJerk.mean.X
   * tBodyAccJerk.mean.Y
   * tBodyAccJerk.mean.Z
   * tBodyAccJerk.std.X
   * tBodyAccJerk.std.Y
   * tBodyAccJerk.std.Z
   * tBodyGyro.mean.X
   * tBodyGyro.mean.Y
   * tBodyGyro.mean.Z
   * tBodyGyro.std.X
   * tBodyGyro.std.Y
   * tBodyGyro.std.Z
   * tBodyGyroJerk.mean.X
   * tBodyGyroJerk.mean.Y
   * tBodyGyroJerk.mean.Z
   * tBodyGyroJerk.std.X
   * tBodyGyroJerk.std.Y
   * tBodyGyroJerk.std.Z
   * tBodyAccMag.mean
   * tBodyAccMag.std
   * tGravityAccMag.mean
   * tGravityAccMag.std
   * tBodyAccJerkMag.mean
   * tBodyAccJerkMag.std
   * tBodyGyroMag.mean
   * tBodyGyroMag.std
   * tBodyGyroJerkMag.mean
   * tBodyGyroJerkMag.std
   * fBodyAcc.mean.X
   * fBodyAcc.mean.Y
   * fBodyAcc.mean.Z
   * fBodyAcc.std.X
   * fBodyAcc.std.Y
   * fBodyAcc.std.Z
   * fBodyAccJerk.mean.X
   * fBodyAccJerk.mean.Y
   * fBodyAccJerk.mean.Z
   * fBodyAccJerk.std.X
   * fBodyAccJerk.std.Y
   * fBodyAccJerk.std.Z
   * fBodyGyro.mean.X
   * fBodyGyro.mean.Y
   * fBodyGyro.mean.Z
   * fBodyGyro.std.X
   * fBodyGyro.std.Y
   * fBodyGyro.std.Z
   * fBodyAccMag.mean
   * fBodyAccMag.std
   * fBodyBodyAccJerkMag.mean
   * fBodyBodyAccJerkMag.std
   * fBodyBodyGyroMag.mean
   * fBodyBodyGyroMag.std
   * fBodyBodyGyroJerkMag.mean
   * fBodyBodyGyroJerkMag.std

   


Transformations Applied
-----------------------

   The transformations applied to the original raw data linked in Data Description are enlisted in this section and described for reproducibility purposes. The reader should also refer to the [README](https://github.com/csmc88/accel_data/blob/master/README.md) and the [ScriptDesc](https://github.com/csmc88/accel_data/blob/master/ScriptDesc.md) files which further explain the code that performs these transformations.
   
   * All raw data files are combined to a single data frame
   * Preset column order is: 'activity', 'subjectID' and all available features under study.
   * Column names are extracted from 'features.txt'
   * Columns are named as 'activity', 'subjectID', and the names extracted from 'features.txt'
   * Data frame is sorted according to 'activity' and 'subjectID' values
   * 'subjectID' column is replaced by a factor equivalent
   * Only column names that refer to mean and standard deviation (std) values are kept.
   * Column names are formatted to eliminate parenthesis '()' characters
   * Column names are modified to replace hyphen '-' characters with dots '.'
   * Data frame is transformed to the average of each feature for each 'activity' and 'subjectID'