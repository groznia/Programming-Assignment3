# Getting and Cleaning Data - Assignment3

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

The run_analysis.R script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here's roughly how the script works:
1. I first upload the data files.
2. I load the activity labels and features from the text files in the unzipped folder. Then I select just the features I want -- the ones containing standard deviations and means. After that, I subset the selected features to create a new data set that contains just the features containing stdev and means.
3. When I load the training and test data, I subset the values corresponding to the "featureswanted" -- i.e. the means and standard deviations. This step lets me create training and test data sets that contain only the relevant values (means and stdev).
4. I combine the training and test data using rbind
5. I merged the "combined" data set with a data set containing the ID number and names for the six activities. Then I got rid of the now-superfluous "activitynumber" (ID number of each activity) column to clean up the data set. This step isn't necessary.
6. Using dplyr package, I created a tidy data set with mean values for each activity and subject. I did so by first grouping by "activityname" and "subjectnumber" before calculating the means for each category 
7. Write the tidy data set into a text file and you're all set.

Please refer to the CodeBook.md for more explanations.
