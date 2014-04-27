CodeBook for tidy.txt
=====================

This document describes the output table of run_analysis.R which is displayed in console after running the script and also saved in a file named 'tidy.txt'. The following sections include

   * __Data Description__ : Provide insight to the origin of the dataset as well as a brief description on how it should be interpreted.
   * __Variable Description__ : Provide column name explanations and descriptions.
   * __Transformations Applied__ : Provide the list of transformations applied to the original raw data.
   
   
   
Data Description
----------------

   The data is obtained after running run_analysis.R given that the [Samsung Accelerometer Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has been succesfully downloaded and unzipped as the [README](https://github.com/csmc88/accel_data/blob/master/README.md) suggests to do so. Data is composed of Accelerometer and Gyroscope measurements on dimensions x, y and z. No specific units are disclosed.
   
   The experiment the data was obtained from consists on 30 subjects performing 6 different tasks and being measured using accelerometer measurements to study their behaviour. The original data collected consisted on 563 columns and 10299 rows divided along 6 files with specific purposes. More information on the README.txt within the Samsung Data.  
   
   The tidy data describes the average values of a subset of the original variables for each combination of activity and subject observed and evaluated. It consists on 68 columns and 180 rows. The values contained in the table are the calculated average of each subset, which refer the mean or standard deviation of another variable.
   

Variable Description
--------------------

   The features selected for this dataset come from accelerometer and gyroscope measurements. The following list explains column name constructs depending on measurement unit and origin.
   
   * `time` ~ Prefix that denotes time. 
   * `frequency` ~ Prefix that denotes frequency domain signals (After applying fast fourier transform)
   * `x/y/z` ~ Suffix that specifies the dimension of measurement.
   * `acc` ~ Accelerometer signal measurement.
   * `body` ~ Measurement signal of body.
   * `gravity` ~ Measurement signal of Gravity.
   * `jerk`~ Derivation of Acceleration and Angular Velocity.
   * `mag` ~ Magnitude of signal calculated with Euclidean norm. No need of letter suffix.
   * `gyro` ~ Gyroscope measurement signal.
   * `mean` ~ Measurement is the mean of the described observations.  
   * `std` ~ Measurement is the Standard Deviation of the described observations.
   
   Additionally two columns are added
   
   * `activity` ~ Measured activity descriptive name.
   * `subject` ~ Subject that performed the measured activity.
   
   The columns included in the datased are included in the following list and should be interpreted using the previous explanations.
   
   * activity
   * subject
   * timebodyaccmeanx
   * timebodyaccmeany
   * timebodyaccmeanz
   * timebodyaccstdx
   * timebodyaccstdy
   * timebodyaccstdz
   * timegravityaccmeanx
   * timegravityaccmeany
   * timegravityaccmeanz
   * timegravityaccstdx
   * timegravityaccstdy
   * timegravityaccstdz
   * timebodyaccjerkmeanx
   * timebodyaccjerkmeany
   * timebodyaccjerkmeanz
   * timebodyaccjerkstdx
   * timebodyaccjerkstdy
   * timebodyaccjerkstdz
   * timebodygyromeanx
   * timebodygyromeany
   * timebodygyromeanz
   * timebodygyrostdx
   * timebodygyrostdy
   * timebodygyrostdz
   * timebodygyrojerkmeanx
   * timebodygyrojerkmeany
   * timebodygyrojerkmeanz
   * timebodygyrojerkstdx
   * timebodygyrojerkstdy
   * timebodygyrojerkstdz
   * timebodyaccmagmean
   * timebodyaccmagstd
   * timegravityaccmagmean
   * timegravityaccmagstd
   * timebodyaccjerkmagmean
   * timebodyaccjerkmagstd
   * timebodygyromagmean
   * timebodygyromagstd
   * timebodygyrojerkmagmean
   * timebodygyrojerkmagstd
   * frequencybodyaccmeanx
   * frequencybodyaccmeany
   * frequencybodyaccmeanz
   * frequencybodyaccstdx
   * frequencybodyaccstdy
   * frequencybodyaccstdz
   * frequencybodyaccjerkmeanx
   * frequencybodyaccjerkmeany
   * frequencybodyaccjerkmeanz
   * frequencybodyaccjerkstdx
   * frequencybodyaccjerkstdy
   * frequencybodyaccjerkstdz
   * frequencybodygyromeanx
   * frequencybodygyromeany
   * frequencybodygyromeanz
   * frequencybodygyrostdx
   * frequencybodygyrostdy
   * frequencybodygyrostdz
   * frequencybodyaccmagmean
   * frequencybodyaccmagstd
   * frequencybodyaccjerkmagmean
   * frequencybodyaccjerkmagstd
   * frequencybodygyromagmean
   * frequencybodygyromagstd
   * frequencybodygyrojerkmagmean
   * frequencybodygyrojerkmagstd

   


Transformations Applied
-----------------------

   The transformations applied to the original raw data linked in Data Description are enlisted in this section and described for reproducibility purposes. The reader should also refer to the [README](https://github.com/csmc88/accel_data/blob/master/README.md) and the [ScriptDesc](https://github.com/csmc88/accel_data/blob/master/ScriptDesc.md) files which further explain the code that performs these transformations.
   
   * All raw data files are combined to a single data frame
   * Preset column order is: 'activity', 'subject' and all available features under study.
   * Column names are extracted from 'features.txt'
   * Columns are named as 'activity', 'subject', and the names extracted from 'features.txt'
   * Data frame is sorted according to 'activity' and 'subject' values
   * 'subject' column is replaced by a factor equivalent
   * Only column names that refer to mean and standard deviation (std) values are kept.
    * This version does not take meanFreq() as a selected mean column as it is not a pure average but a weighted average calculation.
   * Column names are formatted to eliminate parenthesis '()' characters
   * Column names are modified to replace hyphen '-' characters with dots '.'
   * Data frame is transformed to the average of each feature for each 'activity' and 'subject'