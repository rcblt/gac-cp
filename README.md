# gac-cp

## Coursera Getting and Cleaning Data Course Project

### Summary

1. Repo content
2. Generation of output file
3. Usage of tidy dataset
4. Requirements
5. Features file

### 1 Repo content

This repo contains the following files

* **UCI HAR Dataset**: a directory containing ths source data files
* **CodeBook.md**: the code book explaining meaning of variables (i.e. columns) contained in the output file of **run_analysis.R**
* **README.md**: thisfile
* **features_cleaned.txt**: a list of "cleaned up" columns names of the source data files
* **run_analysis.R**: R script to generate the tidy dataset output file from the source data

### 2 Generation of output file

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
		
	and the output file **tidyData.txt** containing the tidy dataset

### 5 Usage of tidy dataset

In order to load the generated tidy dataset in R use the following command:

		read.table("tidyData.txt", header = TRUE, sep = "")
		
the resulting data frame should have 180 rows and 88 columns.

### 4 Requirements

In order to run the **run_analysis.R** script the following software and packages are required:

* **R**
* **dplyr** package

This repo has been created and tested with R ver. 3.1.2 and dplyr ver. 0.3.0.2.

### 5 Features file

The file **features_cleaned.txt** has been obtained editing the source file **features.txt** contained in the **UCI HAR Dataset**. The following changes has been applied:

1. Removal of the first column containing the row number
2. Replacement of the leading 't' character with the word 'time'
3. Replacement of the leading 'f' character with the word 'frequency'
4. Replacement of the word 'Acc' with 'Acceleration'
5. Correction of the double 'BodyBody' with 'Body' at lines 516-554
6. Replacement of 'mad' with 'median', 'sma' with 'SignalMagnitudeArea', 'iqr' with 'InterQuartileRange', 'AutoregressionCoefficient' and 'maxInds' with 'MaxIndexes'
6. Replacement of the character '-' either capitalizing the following word (i.e. obtaining  camelCase name) or removing the '-' completely (for example the trailing -X into X)
7. Removal of the characters '()' except in the last seven lines

