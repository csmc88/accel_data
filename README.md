Getting & Cleaning Data - Peer Assessment
=========================================

Repo Description  
----------------
   This repository was created as part of the Peer Assessment for the "Getting & Cleaning Data" Coursera Class for a Data Science Specialization on April 25th, 2014. The present README explains the structure of the repository structure, contains script assumptions and content explanations.

Contents
--------
   * __README.md__ : Explains the purpose of each file, assumptions before execution and interactions if any.  
   * __CodeBook.md__ : Explains the transformations performed during the Cleaning Process.  
   * __run_analysis.R__ : Contains the R code to perform the Cleaning Process over the Samsung data.
   * __ScriptDesc.md__ : Throughfully explains each function in run_analysis.R

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