## This script converts the source data in a tidy dataset as
## requested by the Course Project of the Getting and Cleaning
## Data course (getdata-010) on Coursera

## Write a short comment describing this function
##

## Load libraries
print("Loading libraries...")
myPackages <- rownames(installed.packages())
if (!"dplyr" %in% myPackages)
  stop("dplyr package is not installed, aborting")

library(dplyr, quietly = TRUE)
rm(myPackages)

## Check for source data directory and required files
print("Checking for required source data...")
if (!file.exists("UCI HAR Dataset"))
  stop("Source data directory 'UCI HAR Dataset' does not exist, aborting")
if (!file.info("UCI HAR Dataset")$isdir)
  stop("'UCI HAR Dataset' is not a directory, aborting")
myRequiredFiles <- c("UCI HAR Dataset/test/subject_test.txt", 
                     "UCI HAR Dataset/test/X_test.txt", 
                     "UCI HAR Dataset/test/y_test.txt",
                     "UCI HAR Dataset/train/subject_train.txt",
                     "UCI HAR Dataset/train/X_train.txt", 
                     "UCI HAR Dataset/train/y_train.txt", 
                     "features_cleaned.txt")
for (myFile in myRequiredFiles) { 
  if (!file.exists(myFile)) 
    stop(paste("File '", myFile, "' does not exist, aborting"))
}
rm(myRequiredFiles, myFile)

## Value names
print("Loading variable names...")
features <- read.table("features_cleaned.txt", 
                       header = FALSE, 
                       sep = "", 
                       as.is = TRUE
)
## Assign column name
names(features) <- c("names")

## Get activity labels
print("Loading activity labels...")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                             header = FALSE, 
                             sep = "", 
                             as.is = TRUE, 
                             col.names = c("activityId", "activityName")
)

## Test set activities
print("Loading activities from test data...")
activities <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     header = FALSE, 
                     sep = "", 
                     dec = ".", 
                     as.is = TRUE,
                     col.names = c("activityId")
                     )
activities <- inner_join(activities, activityLabels, by = "activityId")

## Test set subject
print("Loading subjects from test data...")
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           header = FALSE, 
                           sep = "", 
                           dec = ".", 
                           as.is = TRUE,
                           col.name = c("subjectId")
                           )

## Test set values
print("Loading values from test data...")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     header = FALSE, 
                     sep = "", 
                     dec = ".", 
                     as.is = TRUE
                     )

## Assign variable names
names(X_test) <- features$names

## Initial merged data
mergedData <- cbind(subjects, activities$activityName, X_test)

## Clean up variables before reading train data
rm("subjects", "activities", "X_test")

## Train set activity
print("Loading activities from train data...")
activities <- read.table("UCI HAR Dataset/train/y_train.txt", 
                         header = FALSE, 
                         sep = "", 
                         dec = ".", 
                         as.is = TRUE,
                         col.names = c("activityId")
)
activities <- inner_join(activities, activityLabels, by = "activityId")

## Train subjects
print("Loading subjects from train data...")
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                       header = FALSE, 
                       sep = "", 
                       dec = ".", 
                       as.is = TRUE,
                       col.name = c("subjectId")
)

## Train values
print("Loading values from train data...")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      header = FALSE, 
                      sep = "", 
                      dec = ".", 
                      as.is = TRUE
)

## Assign variable names
names(X_train) <- features$names

## Build train data
X_train <- cbind(subjects, activities$activityName, X_train)

## Complete merged data
print("Craeting merged dataset...")
mergedData <- rbind(mergedData, X_train)
names(mergedData)[2] <- "activityName"

## Clean up objects no more needed
print("Cleaning up...")
rm(activities, subjects, X_train)

## Get the column names containing 'mean' or 'std'
print("Getting mean or std data only...")
meanOrStd <- grepl("mean", features$names, ignore.case = TRUE) | 
  grepl("std", features$names, ignore.case = TRUE)

## Select the required columns only
selectedData <- mergedData[, c(TRUE, TRUE, meanOrStd)]
names(selectedData) <- gsub("[0-9]+_", "", names(selectedData))

## Generated the tidy dataset
print("Generating the output dataset...")
tidyData <- selectedData %>%
  group_by(subjectId, activityName) %>%
  summarise_each(funs(mean))
tidyData <- ungroup(tidyData)

## Writing output file
print("Writing output file tidyData.txt...")
write.table(tidyData,
            file = "./tidyData.txt",
            row.names = FALSE,
            quote = FALSE)

## Clean up objects no more needed
print("Cleaning up...")
rm(mergedData, features, activityLabels, meanOrStd, selectedData, tidyData)

