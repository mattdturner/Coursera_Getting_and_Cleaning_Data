# Getting and Cleaning Data
# Final Project
#
# Author: Matt Turner
# Date created: July 19, 2016

# Set the working directory to the project root
setwd("/Users/matthewturner/Desktop/School/Coursera/Getting_And_Cleaning_Data/final_project/")

# Load libraries
library(reshape2)

# Download the data and save into the data folder
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname <- "UCI_HAR_Dataset.zip"
if ( ! file.exists(fname) ){
    print("File does not currently exist... downloading")
    download.file(url,fname,method="curl")
}

# Extract the data from the archive, and store in a separate data folder
data_dir <- 'UCI HAR Dataset'
if ( ! file.exists(data_dir) ){
    print("Extracting the contents of the .zip archive")
    unzip(fname,list=FALSE,overwrite=TRUE)
    
}

# Load the activity and feature information
activity <- read.table(file.path(data_dir,"activity_labels.txt"))
activity[,2] <- as.character(activity[,2])
features <- read.table(file.path(data_dir,"features.txt"))
features[,2] <- as.character(features[,2])

# Grab information about only the mean / std deviation features
desired_features <- grep('.*mean.*|.*std.*',features[,2])
desired_feature_names <- features[desired_features,2]
# Remove all non-alpha-neumeric characters
desired_feature_names <- gsub('-mean','Mean',desired_feature_names)
desired_feature_names <- gsub('-std','Std',desired_feature_names)
desired_feature_names <- gsub('[-()]','',desired_feature_names)

# Load the training data  and merge to a dataframe
training_data <- read.table(file.path(data_dir,"train/X_train.txt"))[desired_features]
training_activity <- read.table(file.path(data_dir,"train/y_train.txt"))
training_subjects <- read.table(file.path(data_dir,"train/subject_train.txt"))
training <- cbind(training_subjects,training_activity,training_data)

# Load the testing data  and merge to a dataframe
testing_data <- read.table(file.path(data_dir,"test/X_test.txt"))[desired_features]
testing_activity <- read.table(file.path(data_dir,"test/y_test.txt"))
testing_subjects <- read.table(file.path(data_dir,"test/subject_test.txt"))
testing <- cbind(testing_subjects,testing_activity,testing_data)

# Merge the datasets
merged_data <- rbind(training,testing)

# Assing lables to the merged_data
colnames(merged_data) <- c("subjectID","activityName",desired_feature_names)

# Convert activity information into factors
merged_data$activityName <- factor(merged_data$activityName,levels=activity[,1],labels=activity[,2])

# Convert subject information into factors
merged_data$subjectID <- as.factor(merged_data$subjectID)

# Melt the data...
melted_data <- melt(merged_data,id=c("subjectID","activityName"))

# Get the means
mean_data <- dcast(melted_data,subjectID+activityName~variable,mean)

# Write the data to file
write.table(mean_data,"tidy.txt",row.names=FALSE,quote=FALSE)
