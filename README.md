# Getting and Cleaning Data - Course Project

## Analysis of the Human Activity Recognition Using Smartphones Dataset
### README.md
### Dale V. Georg

## Introduction
This project contains a single R script which can be used to perform an analysis of the "Human Activity Recognition Using Smartphones" datasets.  Those datasets and their descriptions can be found at the following URLs:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Installation
After downloading the datafile ZIP, unzip it to the same directory as the run\_analysis.R script in this package.  If you've done this correctly, you will have run\_analysis.R at the same level as the "UCI HAR Dataset" directory.  Set your working directory to the directory where these two reside.

For example, if you have:
	~/my\_stuff/R/run\_analysis.R
	~/my\_stuff/R/UCI HAR Dataset

Then you would set your working directory to ~/my\_stuff/R

## Execution
source("./run\_analysis.R") will run the script. The output of the script will be a file called ./UCI\_HAR\_Analysis.txt.  This file will contain one row for each subject/activity, with the average values for all measurements involving means or standard deviations.

Note that when running the script, you will see a message that a number of warnings have occured.  This is due to certain values being coerced to NA during the processing, and may be safely ignored.