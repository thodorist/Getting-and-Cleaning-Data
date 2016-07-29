# Getting and Cleaning Data-Course Project

----------------------------------------

## Description and goals of the project
One of the most exciting areas in all of data science right now is wearable computing - see for example this article(<http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/>). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##  Files
* The `run_analysis.R` file contains the R-code that we used in order to perform the aforementioned 5 steps of the project. In addition, the code is reproducible meaning that it can produce the same results to any pc. All the relevant data that we need to download will be saved in the working directory and hence there is no need for any other specification. Hence, the code stands on its own.
* The `TidyDataSet.txt` file contains the independent tidy data set which was created in step 5. It is a text file which groups the merged data set, from step 1, by subject and activity, and calculates the mean value of all the variables that included measurements related to either mean or standard deviation.
* The `CodeBook.md` file is a markdown file that describes the variables, the data, and any transformations or work that we performed to clean up the data.