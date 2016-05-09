# First clear the environment to give us a fresh start.
rm(list = ls())

# Next load any libraries we will need.
library(dplyr)
library(plyr)

# Now load all of the datafiles into separate variables.

# The following two vaiables hold the names of the activities and the features, respectivity.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# The following three vaiables hold the data for the subjects in the "TEST" group
# All three of these have the same number of rows; subject_test contains one column
# where each row indicates the subject ID for the sample data in the corresponding
# row in the x_test dataframe. y_test contains a single column where each row indicates
# the activity ID for for the sample data in the corresponding row in the x_test dataframe.
# And x_test is a 561-column dataframe with the actual sample data.
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# The following three vaiables hold the data for the subjects in the "TRAIN" group.
# Their structure corresponds to that of the "test" group above.  Note that there is no
# overlap between the subject IDs in the two groups.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Next we will row bind the sample data from the "train" group to the sample data from
# the "test" group. The resulting dataset will have 561 columns, each column representing 
# one variable in the sample data.
all_sample_data <- rbind(x_test, x_train)

# Since the columns in all_sample_data are named unhelpfully as "V1", V2", etc., we will
# rename them with the values from the "features" file.
colnames(all_sample_data) <- features[,2]

# Now we will do a similar thing for the subject data, row binding the "train" group
# activities to the "test" group activities, and giving the column a meaningful name.
all_subjects <- rbind(subject_test, subject_train)
colnames(all_subjects) <- "subject"

# Now we will do a similar thing for the activity data, row binding the "train" group
# activities to the "test" group activities, and giving the column a meaningful name.
all_activities <- rbind(y_test, y_train)
colnames(all_activities) <- "activity_label"

# At this point, we have three key dataframes:
#   1) all_sample_data - 561 columns with rows for both "test" and "train" groups
#   2) all_subjects - 1 column with rows for the subject IDs that correspond to the rows
#      in all_sample_data
#   3) all_activities - 1 column with rows for the activity IDs (labels) that correspond 
#      to the rows in all_sample_data

# Before we merge these three into a single dataset, however, there is one more thing
# we want to do; namely, changing the activity labels (1, 2, ...) to the activity names

# ("WALKING", "WALKING UPSTAIRS", ...)

# The activity_labels dataframe has six rows and 2 columns, and contains the mapping 
# from the activity IDs to the names.  We'll start by giving the columns descriptive
# names.
colnames(activity_labels) <- c("activity_label", "activity_name")

# In a moment, we will use the merge() function to join all_activities with activity_labels
# so that all_activities will have a new column listing the name of the activity. However,
# the merge() function does not preserve row order, which is important ince our three key
# dataframes are mapped together by row order.  Therefore, we'll introduce a row_id column
# onto all_activities so that we can use it to maintain the row order.
all_activities$row_id <- 1:nrow(all_activities)
all_activities <- all_activities %>% merge(activity_labels) %>% arrange(row_id)

# Column bind the activity name column and the subject column into the all_sample_data dataframe
# The result will be a tidy dataframe with one column for the subjects, one column for the 
# activites, and 561 columns for the measurements.
tidy_data <- cbind(all_sample_data, cbind("activity"=all_activities[,c("activity_name")], all_subjects))

# Next we need to filter the columns so that we include activity, subject, and then only those 
# columns containing means and standard deviations
meanstd <- tidy_data[, grep("-mean\\(\\)$|-std\\(\\)$|^activity$|^subject$", colnames(tidy_data))]

# Next thing we need to do is to summarize the data by subject and activity
meanstd_summary <- aggregate(meanstd, list(meanstd$subject, meanstd$activity), mean)
meanstd_summary <- meanstd_summary[, !(names(meanstd_summary) %in% c("activity", "subject"))]
meanstd_summary <- rename(meanstd_summary, c("Group.1"="subject", "Group.2"="activity"))

# Finally, output the dataframe to a text file
write.table(meanstd_summary, "./UCI_HAR_Analysis.txt", row.names=FALSE)