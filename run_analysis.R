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
if (!"tidyr" %in% myPackages)
  stop("tidyr package is not installed, aborting")
library(dplyr, quietly = TRUE)
library(tidyr, quietly = TRUE)
rm(myPackages)

## Check for source data directory and required files
print("Checking for required source data...")
if (!file.exists("UCI HAR Dataset"))
  stop("Source data directory 'UCI HAR Dataset' does not exist, aborting")
if (!file.info("UCI HAR Dataset")$isdir)
  stop("'UCI HAR Dataset' is not a directory, aborting")
myRequiredFiles <- c("test/subject_test.txt", 
                     "test/X_test.txt", 
                     "test/y_test.txt",
                     "train/subject_train.txt",
                     "train/X_train.txt", 
                     "train/y_train.txt", 
                     "features.txt")
for (myFile in myRequiredFiles) { 
  if (!file.exists(paste("UCI HAR Dataset/", myFile, sep = ""))) 
    stop(paste("File '", myFile, "' does not exist, aborting"))
}
rm(myRequiredFiles, myFile)

## Value names
print("Loading variable names...")
features <- read.table("UCI HAR Dataset/features.txt", 
                       header = FALSE, 
                       sep = "", 
                       as.is = TRUE
)
## Clean up names
features <- features %>% mutate(V2 = gsub("[()]", "", V2))
features <- features %>% mutate(V2 = gsub(",", "_", V2))


## Test activity
print("Loading activities from test data...")
activities <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     header = FALSE, 
                     sep = "", 
                     dec = ".", 
                     as.is = TRUE,
                     col.names = c("activityName")
                     )

## Test subject
print("Loading subjects from test data...")
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           header = FALSE, 
                           sep = "", 
                           dec = ".", 
                           as.is = TRUE,
                           col.name = c("subjectId")
                           )

## Test values
print("Loading values from test data...")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     header = FALSE, 
                     sep = "", 
                     dec = ".", 
                     as.is = TRUE
                     )

## Assign variable names
names(X_test) <- features$V2

## Initial merged data
mergedData <- cbind(subjects, activities, X_test)

## Clean up variables before reading train data
rm("subjects", "activities", "X_test")

## Train activity
print("Loading activities from train data...")
activities <- read.table("UCI HAR Dataset/train/y_train.txt", 
                         header = FALSE, 
                         sep = "", 
                         dec = ".", 
                         as.is = TRUE,
                         col.names = c("activityName")
)

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
names(X_train) <- features$V2

## Build train data
X_train <- cbind(subjects, activities, X_train)

## Complete merged data
print("Craeting merged dataset...")
mergedData <- rbind(mergedData, X_train)

## Clean up objects no more needed
print("Cleaning up...")
rm(activities, subjects, X_train)

