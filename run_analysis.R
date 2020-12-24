#downloaded the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#set the working directory

setwd("C:/~./CourseraProject") #unzip into the downloaded file into the working directory

#packages
library(data.table)
library(dplyr)

datapath<-file.path("C:/~./CourseraProject", "UCI HAR Dataset")
files<-list.files(datapath, recursive=TRUE)

#training data
xtrain<-read.table(file.path(datapath, "train", "X_train.txt"),header = FALSE) #X_train
ytrain<-read.table(file.path(datapath, "train", "y_train.txt"),header = FALSE) #Y_train
strain<-read.table(file.path(datapath, "train", "subject_train.txt"),header = FALSE) #subject_train

#test data
x_test<-read.table(file.path(datapath, "test", "X_test.txt"),header = FALSE) #X-test
y_test<-read.table(file.path(datapath, "test", "y_test.txt"),header = FALSE) #Y_test
s_test<-read.table(file.path(datapath, "test", "subject_test.txt"),header = FALSE) #subject_test

#activity labels and features name
features_names<-read.table(file.path(datapath, "features.txt"),header = FALSE) 
activity_labels<-read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)

#combining training data and test data
features<-rbind(xtrain, x_test)
activity<-rbind(ytrain, y_test)
subject<-rbind(strain, s_test)

#naming the columns
colnames(features)<-t(features_names[2]) #2 select column 2 where the names are stored
colnames(activity)<-"Activity" 
colnames(subject)<-"Subject"

#combining features, activity and subject in one data set called project_data
project_data<-cbind(features,activity,subject) #Requirement 1: Merges the training and the test sets to create one data set

#names
names(project_data) #gives all the column names

#obtaining measurements on the mean and standard deviation
columns_with_mu_sigma<-grep(".*Mean.*|.*Std.*", names(project_data), ignore.case=TRUE) #Extracts only the measurements on the mean and standard deviation for each measurement.

new_Columns_required<-c(columns_with_mu_sigma, 562, 563)

new_project_data<-project_data[,new_Columns_required] #extracted data

#Uses descriptive activity names to name the activities in the data set
new_project_data$Activity<-as.character(new_project_data$Activity)
new_project_data$Activity<-as.factor(new_project_data$Activity) #setting activity as a factor variable

#labeling the data set with descriptive variable names
names(new_project_data)<-gsub("Acc", "Accelerometer", names(new_project_data))
names(new_project_data)<-gsub("Gyro", "Gyroscope", names(new_project_data))
names(new_project_data)<-gsub("BodyBody", "Body", names(new_project_data))
names(new_project_data)<-gsub("Mag", "Magnitude", names(new_project_data))
names(new_project_data)<-gsub("^t", "Time", names(new_project_data))
names(new_project_data)<-gsub("^f", "Frequency", names(new_project_data))
names(new_project_data)<-gsub("tBody", "TimeBody", names(new_project_data))
names(new_project_data)<-gsub("-mean()", "Mean", names(new_project_data), ignore.case = TRUE)
names(new_project_data)<-gsub("-std()", "STD", names(new_project_data), ignore.case = TRUE)
names(new_project_data)<-gsub("-freq()", "Frequency", names(new_project_data), ignore.case = TRUE)
names(new_project_data)<-gsub("angle", "Angle", names(new_project_data))
names(new_project_data)<-gsub("gravity", "Gravity", names(new_project_data))

#creating data table
new_project_data$Subject<-as.factor(new_project_data$Subject) #setting subject as a factor variable
new_project_data<-data.table(new_project_data)

#tidydata
tidy_data<-aggregate(. ~Subject + Activity, new_project_data, mean)
tidy_data<-tidy_data[order(tidy_data$Subject,tidy_data$Activity),]

#writing tidy data into .txt file
write.table(tidy_data, file = "Tidy.txt", row.names = FALSE)

View(tidy_data) #view full datasset

#REFERENCE
#<http://ajay2589.github.io/GettingAndCleaningData/analysis.html>
