# download zip file
urlzip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlzip, "file.zip")
unzip(zipfile = "file.zip")     #unzip file

# convert all text files to data.frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("n", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "n")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "n")

# download packages
library(dplyr)
library(tidyr)

# merge dataframes into one
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
merged_df <- rbind(train, test)

# extract columns and merge with activities dataframe to add appropriate labels
extracted_df <- merged_df %>% select(subject, n, contains("mean")|contains("std"))
extracted_df <- merge(activities, extracted_df, "n")

# modify column names, add descriptive variable names
names(extracted_df)<- gsub(pattern = "Acc", replacement = "Accelerometer",x = names(extracted_df))
names(extracted_df)<- gsub(pattern = "Gyro", replacement = "Gyroscope",x = names(extracted_df))
names(extracted_df)<- gsub(pattern = "BodyBody", replacement = "Body",x = names(extracted_df))
names(extracted_df)<- gsub(pattern = "Mag", replacement = "Magnitude",x = names(extracted_df))
names(extracted_df)<- gsub(pattern = "^t", replacement = "Time",x = names(extracted_df))
names(extracted_df)<- gsub(pattern = "^f", replacement = "Frequency",x = names(extracted_df))
names(extracted_df)<- gsub(pattern = "tBody", replacement = "TimeBody",x = names(extracted_df))

# create a second dataframe with average of each variable
independent_df <- data.frame(colMeans(extracted_df[3:(dim(extracted_df)[2])]))
names(independent_df) <- "mean"