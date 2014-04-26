Getting & Cleaning Data - Peer Assessment
=========================================

Repo Description  
----------------
   This repository was created as part of the Peer Assessment for the "Getting & Cleaning Data" Coursera Class for a Data Science Specialization on April 25th, 2014. The present README explains the structure of the repository structure, contains script assumptions and content explanations.  

Contents
--------
   * __README.md__ : The first section explains the purpose of each file, assumptions before execution, execution instructions, output description and License. The second section contains a throughful explanation of each function in run_analysis.R  
   * __CodeBook.md__ : Explains the transformations performed during the Cleaning Process.  
   * __run_analysis.R__ : Contains the R code to perform the Cleaning Process over the Samsung data.  
   * __ScriptDesc.md__ : Contains a more throughful explanation of run_analysis.R than README.md
   * __tidy.txt__ : Result table after running the provided R script.  

Assumptions
-----------  
   * The provided R script requires the [Samsung Accelerometer Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to be previously downloaded.  
   * The directory structure and file names must be kept the same as described in the following section. The structure described matches the one included in the file downloaed using the previous link. 
   * The file is zipped and should be unzipped before running the scripts.
   * Additionally, unzipped data must be saved in the working directory inside a directory named _UCI HAR Dataset_ as it is also an assumption by the script.  
   * The 'reshape2' package must be installed previous to execution as the R script requires it to run successfully.

Working Directory
-----------------
The expected tree structure of the working directory should be as follows.
   
   * UCI HAR Dataset
    * test
     * Inertial Signals
     * subject_test.txt
     * X_test.txt
     * y_test.txt
    * train
     * Inertial Signals
     * subject_train.txt
     * X_train.txt
     * y_train.txt
    * activity_labels.txt
    * features.txt
    * features_info.txt
    * README.txt
   * CodeBook.md
   * README.md
   * run_analysis.R
   * ScriptDesc.md
   
Execution
---------
   The script can be executed through RGui or a command line.  
   
### Execution Using RGui
   1. Open an R console (Through RGui, RStudio or a similar IDE) in the working directory.  
   2. Execute `source('run_analysis.R')`  
   
### Execution Using Command Line
   1. Open a Command Line Interface in the working directory.  
   2. Execute `Rscript run_analysis.R`  
   
__NOTE:__ The CLI executions assumes that R has been added to the PATH environmental variable.  


License
-------

   The work presented in this repository is owned by the main user account associated with it. The contents of this repository are public and can be forked and manipulated freely for study purposes. However, the contents should not be used to cheat on any class assignment be it by Coursera Inc or any other educative organization.  
   
_**Said Montiel**, April 2014_


R Script Explanation - run_analysis.R
=====================================

This document explains how the functions written inside *run_analysis.R* work together to process Samsung's Accelerometer Raw Data into a tidy dataset as requested by the Peer Assignment Instructions. For this specific task the script was partitioned in several functions that cooperate for this purpose. In the following sections explain how each function works as well as how each relate to the assignment instructions.  

The Assignment instructions provided in the Coursera webpage are listed below and will be referenced during the explanation contained in this document.  

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive activity names.   
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

Each section explains one subfunction. The last section explains the main controlling function.  

_**NOTE: For a more throughful explanation of the R functions please refer to [ScriptDesc.md](https://github.com/csmc88/accel_data/blob/master/ScriptDesc.md)**_



`ReadFiles (type, baseDir)`
---------------------------

   The argument `type` receives a character vector of length one that will be used to identify the subdirectory that must be read as well as to build the file names required. It is important that this holds true else the function fails.  
   The argument `baseDir` receives a character vector of length one that contains the name of the Samsung Accelerometer Data directory that holds all remaining files for analysis.  
   
   The purpose of this function is to sequentially read all files of a specific `type` within the `baseDir` and bind them. It returns a single complete dataset.   
   
   This function is used to satisfy Instruction #1 in `GetAllData` as well as concepts of tidy data regarding column names.  
   
   
   
`GetAllData (baseDir, required)`
--------------------------------

   The argument `baseDir` receives a character vector of length one that contains the name of the Samsung Accelerometer Data directory that holds all remaining files for analysis.  
   The argument `required` receives a character vector which contains the names of all subfolders inside `baseDir` that must be read. It should also be part of the file name format explained in the previous section.  
   
   The purpose of this function is to return the complete dataset which should be a combination of all items in `required`. It will also set the initial column names, convert the subjects column to factor and order the dataset by activity and subject.  

   This function helps to satisfy Instruction #1 as well as tidy data concepts.  
  
  
  
`MeanStdCols (colNames)`
------------------------

   The argument `colNames` receives a character vector containing the column names of a dataset.  
   
   The purpose of this function is to return a numeric vector containing the indices of columns that contain either a mean or standard deviation value.   
   
   This function helps to satisfy Intruction #2.  
   

   
`CleanData (baseDir, required)`
-------------------------------

   The argument `baseDir` receives a character vector of length one that contains the name of the Samsung Accelerometer Data directory that holds all remaining files for analysis.  It defaults to `'UCI HAR Dataset'`.   
   The argument `required` receives a character vector which contains the names of all subfolders inside `baseDir` that must be read. It should also be part of the file name format explained in the previous section. It defaults to `c('train','test')`.   
   
   The purpose of this function is to process the raw data contained in `baseDir` and transform it into a tidy dataset. It does so by calling the other subfunctions explained in this document as well using other R programming concepts and the reshape2 library.  
     
   
   This satisfies all Peer Assignment Instructions.  
   
   
   
   
Output Description
==================

   The output of run_analysis.R is sent to the executing console as well as saved in a TXT file in the working directory. The file saved as 'tidy.txt' contains the result table up to Instruction #5. An additional file up to Instruction #4 is also under the name 'complete.txt'.
   
   Both file contain headers.