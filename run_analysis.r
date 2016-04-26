# Getting and Cleaning Data Course Project
# -----------------------------------------------------------------------------
# Create one R script called run_analysis.R that does the following:
# -1- Merges the training and the test sets to create one data set.
# -2- Extracts only the measurements on the mean and SD for each measurement.
# -3- Uses descriptive activity names to name the activities in the data set.
# -4- Appropriately labels the data set with descriptive variable names.
# -5- From the data set in step 4, creates a second, independent tidy data set
#     with the average of each variable for each activity and each subject.
# -----------------------------------------------------------------------------

# Setup the working environment...

library(data.table)

# Remove everything from the workspace and set the working directory

rm(list = ls())
setwd('W://code//R-Stats//Coursera//03 - GettingAndCleaningData Assgn')

# Define some directorys and load the required data...

mainDir         <- "./UCI HAR Dataset"
testDir         <- "./UCI HAR Dataset/test"
trainDir        <- "./UCI HAR Dataset/train"
labels         <- read.table(paste(mainDir, "activity_labels.txt", sep="/"))
features       <- read.table(paste(mainDir, "features.txt", sep="/"))
subjectTest    <- read.table(paste(testDir, "subject_test.txt", sep="/"))
subjectTrain   <- read.table(paste(trainDir, "subject_train.txt", sep="/"))
xTest          <- read.table(paste(testDir, "X_test.txt", sep="/"))
yTest          <- read.table(paste(testDir, "Y_test.txt", sep="/"))
xTrain         <- read.table(paste(trainDir, "X_train.txt", sep="/"))
yTrain         <- read.table(paste(trainDir, "Y_train.txt", sep="/"))

# Rename the main feature datasets (xTest & xTrain) using the feature list...

names(xTest)  <- features[,2]
names(xTrain) <- features[,2]

# Subset the feature datasets to just include those requested (mean & SD)

reqFeatures <- grepl("mean|std", features[,2])
xTest  <-  xTest[,reqFeatures]
xTrain <- xTrain[,reqFeatures]

# Build the final 'test', 'train' and merged datasets...
# Firstly, for each of 'ytest' and 'ytrain', generate an additional activity
# column for the named activity. Use the 'match' command to match the activity
# IDs to the corresponding activities in 'labels'. After binding the 'subject'
# and 'activity' data together, apply meaningful column names, and then bind in
# the feature data. 

# Make a note of the column names for ID and measurement data...

idLabels <- c("Subject", "Activity", "ActivityID", "Dataset")
measureLabels <- as.character(features[reqFeatures,2])

# First process the 'test' data...

yTest[,2] <- labels[match(yTest[,1], as.integer(labels[,2])),2]
dataTest <- cbind(subjectTest,yTest)
dataTest[,4]<- "test"
names(dataTest) <- idLabels
dataTest <- cbind(dataTest,xTest)

# And repeat on the 'train' data...

yTrain[,2] <- labels[match(yTrain[,1], as.integer(labels[,2])),2]
dataTrain <- cbind(subjectTrain,yTrain)
dataTrain[,4]<- "train"
names(dataTrain) <- idLabels
dataTrain <- cbind(dataTrain,xTrain)

# And now rowbind the 2 datasets together...

dataMerge <- as.data.table(rbind(dataTest,dataTrain))

# Finally, melt the merged data using the ID and measurement column names, and
# recast by Activity and Subject to give the mean of all the other variables by
# those 2 groups. Then write the tidy recast data to file...

dataMelted <- melt(dataMerge, id = idLabels, measure.vars = measureLabels)
dataCast <- dcast(dataMelted, Activity+Subject ~ variable, mean)

write.table(dataCast, file = "./StudyDataTidy.txt")