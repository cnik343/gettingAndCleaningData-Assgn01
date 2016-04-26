## Getting and Cleaning Data Assignment

The final assignment for the "Getting and Cleaning Data" Coursera module is to write a script, run_analysis.R, designed to tidy and reformat a specific fitness tracker dataset. The original data is not included here and needs to be downloaded seperately. For execution the run_analysis.R script should be placed in the directory that contains the "UCI HAR Dataset" directory containing all the original data.

The script run_analysis.R should do the following:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
## The Original Data

* Original data source:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original dataset description:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
## Implementation of run_analysis.R 

 1. Download the original data into a working directory and extract the archive to leave the "UCI HAR Dataset" directory.
 2  Place run_analysis.R in the directory that contains the "UCI HAR Dataset" directory.
 3. Use 'setwd()' to set the working directory in Rstudio to be the same as that containg the script.
 4. Run 'source(run_analysis.R)' to execute the script. This will generate a new file called 'StudyDataTidy.txt'.
 5. The data.table that is written to this file will be in Rstudio and called 'dataCast'.
 
## Execution of run_analysis.R 

The run_analysis.R script operates as follows:

 1. Load all the required data. This is everything in the original dataset excluding the files in the 'Inertial Signals' directorys.
 2. Use the features list to rename the columns in the 'test' and 'train' datasets
 3. Use grep & regex to subset the 'test' and 'train' datasets to keep just those columns labelled matching "mean()" or "std()".
 4. Combine each of the 'test' and 'train' data subsets with the Subject and numerical and descriptive Activity information.
 5. Merge the 'test' and 'train' data subsets including the Subject and Activity information
 6. Melt and recast the merged data to summarize it by mean as a function of both Activity and Subject.
 7. Finally the recast data is output to file.