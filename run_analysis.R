#Main Data Cleanup Function
CleanData <- function(baseDir = 'UCI HAR Dataset',required = c('train','test')){
	#Obtain all raw data in a single data frame
	dataset <- GetAllData(baseDir,required)
	
	#Subset Columns and Rename Columns
	colNames <- names(dataset)
	dataset <- dataset[c(1,2, MeanStdCols(colNames))]
	names(dataset)[-1:-2] <- FormatColNames(colNames[-1:-2])
	
# Uses descriptive activity names to name activities in the dataset
# Appropriately labels the data set with descriptive activity names.
	labelsPath <- file.path(baseDir,'activity_labels.txt')
	activities <- read.table(labelsPath)
	dataset[,1] <- factor(dataset[,1], activities[,1],activities[,2])

# Creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject. 
	library(reshape2)
	melted  <- melt(dataset, id = c('activity','subjectID'))
	morphed <- dcast(melted, activity + subjectID ~ variable, mean, na.rm=TRUE)
	
	write.table(dataset,"complete.txt",row.names=FALSE)
	write.table(morphed,"tidy.txt",row.names=FALSE)
}

#Uses REGEX to extract required columns
MeanStdCols <- function(colNames){
	positions <- grep('mean[(][)]|std[(][)]',colNames)
	return(positions)
}

#Setup all required data
GetAllData <- function(baseDir, required){
	#Read train and test ==> RBIND
	dataset <- do.call(rbind,lapply(required,ReadFiles, baseDir))
	
	#Read and apply correct COLUMN NAMES
	featurePath <- file.path(baseDir,'features.txt')
	colNames <- read.table(featurePath, colClasses = 'character')
	names(dataset) <- c('activity','subjectID',colNames[,2])
	
	#Organize dataset by activity and subject
	dataset <- dataset[order(dataset$activity,dataset$subjectID),]
	
	#Replace subjectID values for factor equivalent
	subjects <- unique(dataset$subjectID)
	subjectNames <- paste0('Subject #',subjects)
	dataset[,2]  <- factor(dataset[,2],subjects, subjectNames)
	
	return(dataset)
}

#Reads all files of a certain type
ReadFiles <- function(type, baseDir){
	#Generate Correct File names
	# fileNames <- list.files(file.path(baseDir,type),'.txt$')
	fileNames <- paste0(c('y_','subject_','X_'),type,'.txt')
	files <- file.path(baseDir,type,fileNames)
	
	#Read and CBIND all files
	dataset <- do.call(cbind,lapply(files,read.table))
	
	return(dataset)
}

CleanData()