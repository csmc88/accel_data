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



`ReadFiles (type, baseDir)`
---------------------------

   The argument `type` receives a character vector of length one that will be used to identify the subdirectory that must be read as well as to build the file names required. It is important that this holds true else the function fails.  
   The argument `baseDir` receives a character vector of length one that contains the name of the Samsung Accelerometer Data directory that holds all remaining files for analysis. 
   
   The purpose of this function is to sequentially read all files of a specific `type` within the `baseDir` and bind them. It returns a single complete dataset.  
   
```{r}
fileNames <- paste0(c('y_','subject_','X_'),type,'.txt')  
files <- file.path(baseDir,type,fileNames)
```
   The first line creates a vector of size 3 (using R's recycling rule) of the file names to be read later and saves it to `fileNames`. The second line uses the `file.path` function combines `fileNames` with `baseDir` and `type` to produce the relative paths to those specific files and saves the results to `files`. This object will be used to find and read the required files.  
   
   Instead of reading all file names automatically with `list.files()`, the function manually generates the file names because this way the order in which the files will be read can be preset. The commented legacy line `fileNames <- list.files(file.path(baseDir,type),'.txt$')` reads all files with a TXT extension inside the directory. Unwanted TXT files could be read or the required files order might change.  
   
```{r}  
dataset <- do.call(cbind,lapply(files,read.table))  
return(dataset)
```  
   
   The first line uses the  `lapply` cycle to read all items in `files` using the default values for the `read.table` function. It is inside a `do.call` loop which takes each data frame inside the `lapply` reference and uses the `cbind` function to output a single data frame saved in `dataset`. The return function then finishes the `ReadFiles` function and returns a complete dataset for the `type` parameter.  
   
   This function is used to satisfy Instruction #1 in `GetAllData` as well as concepts of tidy data regarding column names.
   
   
   
`GetAllData (baseDir, required)`
--------------------------------

   The argument `baseDir` receives a character vector of length one that contains the name of the Samsung Accelerometer Data directory that holds all remaining files for analysis.  
   The argument `required` receives a character vector which contains the names of all subfolders inside `baseDir` that must be read. It should also be part of the file name format explained in the previous section.  
   
   The purpose of this function is to return the complete dataset which should be a combination of all items in `required`. It will also set the initial column names, convert the subjects column to factor and order the dataset by activity and subject.  
  
```{r}  
dataset <- do.call(rbind,lapply(required,ReadFiles, baseDir))
``` 

   The `lapply` function will produce a list with the complete `required` data frames. The `do.call` cycle will merge them using `rbind` to produce the over-all complete data frame saved in `dataset`.
   
```{r}  
featurePath <- file.path(baseDir,'features.txt')
colNames <- read.table(featurePath, colClasses = 'character')
names(dataset) <- c('activity','subjectID',colNames[,2])
``` 

   The first line will generate the path to `features.txt` which is the file containing the column names for all variables under study. The second line reads the required file using `read.table` with `colClasses = 'character'`. It returns a data frame with two columns. The third line replaces the names of the complete dataset with a vector consisting of two preset names `'activity'` and `'subjectID'` and the values inside the second column of `colNames`. Since the column order was chosen inside the `ReadFiles` function this is a correct assignment.  
   
```{r}  
dataset <- dataset[order(dataset$activity,dataset$subjectID),]
``` 

   This line reorganizes the dataset using the `order` function with `activity` as the primary sorting key and `subjectID` as the secondary sorting key. Ordering the data frame at this point is important for future function use and data manipulation.  

```{r}  
subjects <- unique(dataset$subjectID)
subjectNames <- paste0('Subject #',subjects)
dataset[,2]  <- factor(dataset[,2],subjects, subjectNames)
  
return(dataset)
``` 

  The first line extracts the unique values of the column 'subjectID' and assigns them to `subjects`. The second line generates appropriate subject name using the `paste0` function and R's Recycling Rule assigning the result to `subjectNames`. The third line replaces the values in the 'subjectID' column of `dataset` with the `factor` equivalent using `subjects` and `subjectNames` as `levels` and `labels` respectively. The fourth line returns `dataset` as the result of `GetAllData` and ends the function execution.  

   This function helps to satisfy Instruction #1 as well as tidy data concepts.
  
  
  
`MeanStdCols (colNames)`
------------------------

   The argument `colNames` receives a character vector containing the column names of a dataset.
   
   The purpose of this function is to return a numeric vector containing the indices of columns that contain either a mean or standard deviation value.
   
```{r}  
positions <- grep('mean[(][)]|std[(][)]',colNames)
return(positions)
``` 

   The first line runs a Regular Expression over the `colNames` vector and returns a numeric vector containing the indices to columns containing 'mean()' or 'std()' in their name. The regular expression `'mean[(][)]|std[(][)]'` was built rudimentarily with this purpose. The second line returns the obtained vector and finished the function execution.  
   
   This function helps to satisfy Intruction #2.
   

   
`CleanData (baseDir, required)`
----------------------------------------------------------------

   The argument `baseDir` receives a character vector of length one that contains the name of the Samsung Accelerometer Data directory that holds all remaining files for analysis.  It defaults to `'UCI HAR Dataset'`.  
   The argument `required` receives a character vector which contains the names of all subfolders inside `baseDir` that must be read. It should also be part of the file name format explained in the previous section. It defaults to `c('train','test')`.  
   
   The purpose of this function is to process the raw data contained in `baseDir` and transform it into a tidy dataset.
   
   
```{r}  
dataset <- GetAllData(baseDir,required)
``` 

   This calls the `GetAllData` function with the `baseDir` and `required` arguments. It returns a dataset as described in the function description. The output of `GetAllData` is saved in `dataset`.
   
   This satisfies Instruction #1.
   
```{r}  
colNames <- names(dataset)
dataset <- dataset[c(1,2, MeanStdCols(colNames))]
names(dataset) <- FormatColumnNames(colNames)
``` 

   The first line gets the column names of the dataset using the `names` function and assigns the values to the `colNames` variable. The variable will be used on the following lines. The second line subsets the columns of the `dataset` object. It does so by combining the values of 1 and 2 which refer to 'activity' and 'subjectID' columns respectively, together with the output from the `MeanStdCols` function ran with `colNames` as input parameter. The third line replaces the column names of `dataset` using the output from the `FormatColumnNames` function. The `FormatColumnNames` is called with `colNames` as an input parameter.
   Both `MeanStdCols` and `FormatColumnNames` will return the vectors described in previous sections.
   
   These code lines satisfy Instruction #2 and concepts of tidy data.
   
```{r}  
labelsPath <- file.path(baseDir,'activity_labels.txt')
activities <- read.table(labelsPath)
dataset[,1] <- factor(dataset[,1], activities[,1],activities[,2])
``` 

   The first line creates the path to the 'activity_lables.txt' file using the `file.path` function and saves it in `labelsPath`. The second line uses `labelsPath` to read the corresponding file with the `read.table` function using default parameters and saves the resulting data frame in `activities`. The third line replaces the values in the first column of `dataset` with the `factor` equivalent using the columns 1 and 2 of `activities` as `levels` and `labels` respectively.
   
   Up to this point we have covered the first 4 steps of the **Peer Assignment** for **Getting & Cleaning Data** and have obtained what should be our **_tidy dataset_**.  
   
   These code lines satisfy Instructions #3 and #4 as well as tidy data concepts.
   
```{r}  
library(reshape2)
melted  <- melt(dataset, id = c('activity','subjectID'))
morphed <- dcast(melted, activity + subjectID ~ variable, mean, na.rm=TRUE)
``` 

   The first line loads the reshape2 package to the R interpreter. The second line uses the `melt` over `dataset` using the columns 'activity' and 'subjectID' as the `id` parameter. The function will return the melted data frame which sepparates all values originally in `dataset` by the unique combinations of 'activity' and 'subjectID'. The data frame includes the columns 'activity','subjectID','variable' and 'value' The third line executes the `dcast` function using `melted` as the reference data frame to execute the `mean` function over the subsets defined by the formula `activity + subjectID ~ variable`. The `na.rm` parameter of the `mean` function is set to `TRUE`. The result from `dcast` is a data frame consisting of $NumberOfSubjects * NumberOfActivities$ rows with the same column structure and names as `dataset`. The data frame is saved in `morphed`.
   
   Since `dataset` was a data frame ordered from its creation using 'activities' as primary key and 'subjectID' as the secondary key the resulting data frame after `melt` and `dcast` functions are applied is also sorted in the same way giving it a tidy order.
   
   These code lines satisfy Instruction #5.

```{r}  
write.table(dataset,"complete.txt",sep=',',row.names=FALSE)
write.table(morphed,"tidy.txt",sep=',',row.names=FALSE)
```

   The first line saves `dataset` to a file named 'complete.txt' using the `write.table` function and setting its `row.names` parameter to `FALSE`. The second line saves `morphed` to a file named 'tidy.txt' using the `write.table` function and setting its `row.names` parameter to `FALSE`.