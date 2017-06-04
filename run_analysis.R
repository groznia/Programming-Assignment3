#1 Merge the training and the test sets to create one data set.
install.packages("reshape2")
packages <- c("data.table", "reshape2")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "Dataset.zip")
unzip("Dataset.zip")

#Load activity labels and features

activitylabels <- data.table::fread("UCI HAR Dataset/activity_labels.txt",
                                    col.names = c("activitynumber", "activityname"))
features <- data.table::fread("UCI HAR Dataset/features.txt",
                              col.names = c("featurenumber", "featurename"))
featureswanted <- grepl("(mean|std)\\(\\)", features$featurename)
measurements <- features[featureswanted, featurename]

#Load train and test data
#Extract only values for the mean and standard deviation for each measurement
#Appropriately labels the data set with descriptive variable names

train <- data.table::fread("UCI HAR Dataset/train/x_train.txt")[, featureswanted, with=FALSE]
data.table::setnames(train, colnames(train), measurements)
trainsubject <- data.table::fread("UCI HAR Dataset/train/subject_train.txt",
                                  col.names = c("subjectnumber"))
trainactivity <- data.table::fread("UCI HAR Dataset/train/y_train.txt",
                                   col.names = c("activitynumber"))

train <- cbind(trainsubject, trainactivity, train)

test <- data.table::fread("UCI HAR Dataset/test/x_test.txt")[, featureswanted, with=FALSE]
data.table::setnames(test, colnames(test), measurements)
testsubject <- data.table::fread("UCI HAR Dataset/test/subject_test.txt",
                                  col.names = c("subjectnumber"))
testactivity <- data.table::fread("UCI HAR Dataset/test/y_test.txt",
                                   col.names = c("activitynumber"))
test <- cbind(testsubject, testactivity, test)

#combine datasets
combined <- rbind(test, train)

# Uses descriptive activity names to name the activities in the data set
combined <- merge(activitylabels, combined, by="activitynumber")
set(combined, j = 'activitynumber', value = NULL)

#5 From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject
        
library(dplyr)
tidymean <- combined %>% group_by(activityname, subjectnumber) %>% 
        summarise_each(funs(mean))

setwd("UCI HAR Dataset")
data.table::fwrite(x = tidymean, file = "tidydata.txt", quote = FALSE)
