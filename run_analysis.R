#########################################################################
#### Download the zip file and save it in the working directory      ####
#### in a file called "data" where the downloaded zip file is called ####
#### projectDATA.                                                    ####
#########################################################################

if(!file.exists("./data")){dir.create("./data")}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

######################################################################
#### Create the extension of the file I will download the data to ####
#### and save it in a variable called "destination".              ####
######################################################################

destination<-paste0("./data", "/projectDATA.zip")
download.file(fileURL, destfile = destination)

#############################################################
#### Unzip the 'zip' file inside the folder named "data" ####
#### which is located in the working directory.          ####
#############################################################

unzip(destination, exdir = "./data")

############################################################
#### Now a folder named "UCI HAR Dataset" has been      ####
#### created which contains all the relevant data sets. ####
#### Since we will be using it quite often, I will save ####
#### the path to this folder in a separate variable.    ####
############################################################

path<-paste0("./data", "/UCI HAR Dataset")

####################################################################
#### Load the datasets from training data                       ####
#### and save all the datasets into one variable                ####
#### named "trainDATA" where column 1 will show the subject id, ####
#### column 2 will show the type of activity and all the other  ####
#### columns will represent the values of all types of          ####
#### measurements that have been included.                      ####
####################################################################

subject_train<-read.table(paste0(path, "/train/subject_train.txt"))
y_train<-read.table(paste0(path, "/train/y_train.txt"))
X_train<-read.table(paste0(path, "/train/X_train.txt"))

trainDATA<-cbind(subject_train, y_train, X_train)

###################################################################
#### Load the datasets from test data                          ####
#### and save all the datasets into one variable               ####
#### named "testDATA" where column 1 will show the subject id, ####
#### column 2 will show the type of activity and all the other #### 
#### columns will represent the values of all types of         ####
#### measurements that have been included.                     ####
###################################################################

subject_test<-read.table(paste0(path, "/test/subject_test.txt"))
y_test<-read.table(paste0(path, "/test/y_test.txt"))
X_test<-read.table(paste0(path, "/test/X_test.txt"))

testDATA<-cbind(subject_test, y_test, X_test )

##############################################
####                Step 1                ####
#### Merge the training and the test sets ####
#### to create one data set.              ####
##############################################

mergedDATA<-rbind(trainDATA, testDATA)

###########################################################
####                Step 2                             ####
#### Extracts only the measurements on the             ####
#### mean and standard deviation for each measurement. ####
###########################################################

features<-read.table(paste0(path, "/features.txt"))
Index<-grep("[Mm]ean|[Ss]td.", features[,2])
SubsetData<-mergedDATA[, c(1,2, Index + 2)]

################################################
####                Step 3                  ####
#### Use descriptive activity names to name ####
#### the activities in the data set         ####
################################################

activityLabels <- read.table(paste0(path, "/activity_labels.txt"))
SubsetData[, 2]<-activityLabels[SubsetData[, 2], 2]

###############################################
####                Step 4                 ####
#### Appropriately label the data set with ####
#### descriptive variable names.           ####
###############################################

featureNames<-as.character(features[Index, 2])
names(SubsetData)<-c("Subject", "Activity", featureNames)

###########################################################
####                Step 5                             ####
#### From the data set in step 4, creates a second,    ####
#### independent tidy data set with the average of     ####
#### each variable for each activity and each subject. ####
###########################################################

library(dplyr)
Ind.TidyDataset<-SubsetData %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(Ind.TidyDataset, file = "./data/TidyDataSet.txt", row.name = F)
