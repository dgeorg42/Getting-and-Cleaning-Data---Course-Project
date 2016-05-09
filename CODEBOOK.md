# Getting and Cleaning Data - Course Project

## Analysis of the Human Activity Recognition Using Smartphones Dataset

## Introduction
This project contains a single R script (run_analysis.R) which can be used to perform an analysis of the "Human Activity Recognition Using Smartphones" datasets.  Those datasets and their descriptions can be found at the following URLs:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The README.md file explains how to install and run the script.

## Code Description
The run_analysis.R script will do the following:
* Load the required libraries (specifically plyr and dplyr);
* Read the activity_labels.txt and features.txt files to get the names of the activities and features;
* Read the datasets from the "test" directory, which contain the subject IDs, activities, and feature data for those subjects in the "test" group;
* Read the datasets from the "training" directory, which contain the subject IDs, activities, and feature data for those subjects in the "training" group;
* Merge the data together to create a single, tidy dataframe;
* Extract from that tidy dataframe only those measurements that involved means or standard deviations;
* Create a new dataframe averaging those meaurements for each subject/activity;
* Write this new dataset out to a file called ./UCI\_HAR\_Analysis.txt

Note that when running the script, you will see a message that a number of warnings have occured.  This is due to certain values being coerced to NA during the processing, and may be safely ignored.