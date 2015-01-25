# gac-cp

## Coursera Getting and Cleaning Data Course Project

### Summary

* [Repo content](#-repo content-)
* [Generation of output file](#-generation of output file-)
* [Usage of tidy dataset](#-usage of tidy dataset-)
* [Requirements](#requirements)
* [Features file](#-features file-)
* [run_analysis.R](#run_analysis.R)

### Repo content

This repo contains the following files

* **UCI HAR Dataset**: a directory containing ths source data files
* **CodeBook.md**: the code book explaining meaning of variables (i.e. columns) contained in the output file of **run_analysis.R**
* **README.md**: thisfile
* **features_cleaned.txt**: a list of "cleaned up" columns names of the source data files (see [below](#-features file-))
* **run_analysis.R**: R script to generate the tidy dataset output file from the source data

### Generation of output file

To get the output tidy data set from the source data follow these steps:

1. Open R
2. Set the current working directory to the top directory of this repo
3. Source the **run_analysis.R** command:

		source("run_analysis.R")
	
	Your should get this output on the R console:
	
		Loading libraries...
		Checking for required source data...
		Loading variable names...
		Loading activity labels...
		Loading activities from test data...
		Loading subjects from test data...
		Loading values from test data...
		Loading activities from train data...
		Loading subjects from train data...
		Loading values from train data...
		Craeting merged dataset...
		Cleaning up...
		Getting mean or std data only...
		Generating the output dataset...
		Writing output file tidyData.txt...
		Cleaning up...
		
		Read tidy dataset with: read.table("tidyData.txt", header = TRUE, sep = "")
		
	and the output file **tidyData.txt** containing the tidy dataset in the working directory.

### Usage of tidy dataset

In order to load the generated tidy dataset in R use the following command:

		read.table("tidyData.txt", header = TRUE, sep = "")
		
the resulting data frame should have 180 rows and 88 columns.

Read the file **CodeBook.md** for more information about the data contained in the tidy dataset.

### Requirements

In order to run the **run_analysis.R** script the following software and packages are required:

* **R**
* **dplyr** package

This repo has been created and tested with R ver. 3.1.2 and dplyr ver. 0.3.0.2.

### Features file

The file **features_cleaned.txt** has been obtained editing the source file **features.txt** contained in the **UCI HAR Dataset**. This file is used to assign names to the columns of the merged dataset before filtering out those columns that do not contain either the word 'mean' or 'std'. The following changes has been applied:

1. Removal of the first column containing the row number
2. Replacement of the leading 't' character with the word 'time'
3. Replacement of the leading 'f' character with the word 'frequency'
4. Replacement of the word 'Acc' with 'Acceleration'
5. Correction of typos 'BodyBody' with 'Body' at lines 516-554
6. Replacement of 'mad' with 'median', 'sma' with 'SignalMagnitudeArea', 'iqr' with 'InterQuartileRange', 'AutoregressionCoefficient' and 'maxInds' with 'MaxIndexes'
6. Replacement of the character '-' either capitalizing the following word (i.e. obtaining  camelCase name) or removing the '-' completely (for example the trailing -X into X)
7. Removal of the characters '()' except in the last seven lines
8. Replacement of the character '(' with '.' in the last seven lines
9. Removal of the trailing character '(' in the last seven lines

### run_analysis.R

The R script **run_analysis.R** is used to convert the source data contained in the UCI HAR Dataset in the output tidy dataset according to the course project specifications.

The main steps performed by run_analysis.R are:

1. Check if required packages are installed and load them
2. Check that all required source files are present in the current working directory and UCI HAR Dataset sub-directory
3. Read the column names of the output dataset from the file features_cleaned.txt
4. Read the activity labels (i.e. WALKING, SITTING, etc.) from the file activity_labels.txt
5. Read activity, subject and value data from the test dataset
6. Read activity, subject and value data from the train dataset
7. Merge the test and train dataset
8. Filters out the columns (i.e. variables) that does not contain either the word 'mean' or 'std' in the column name
9. Group the resulting data by subject and by activity and compute the mean of all the columns
10. Write the output file tidyData.txt
11. Clean up the environment from the temporary objects created during the conversion

At each step a message is printed to the console. After successful completion the output file is in the current working directory.