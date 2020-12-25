#Tidy data set description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities:
*WALKING, 
*WALKING_UPSTAIRS, 
*WALKING_DOWNSTAIRS, 
*SITTING, 
*STANDING, 
*LAYING) 
*# The variables in the tidy data
run_analysis.R performs the data preparation and then followed by the steps required as described in the course project’s instructions:

  * Downloaded the Dataset zip file.Unzipped the Dataset
  * Loaded datasets from text files.
    *	features_info.txt
    * features.txt
    *	activity_labels.txt
    *	train/X_train.txt
    *	train/y_train.txt
    *	test/X_test.txt
    * test/y_test.txt
    *	train/subject_train.txt
    * train/Inertial Signals/total_acc_x_train.txt
    * train/Inertial Signals/body_acc_x_train.txt
    *	train/Inertial Signals/body_gyro_x_train.txt
* Merged the training and the test sets to create one data set.
* Binded Activity name and subject code to merged data set
* Used descriptive activity names to name the activities in the data set
* Extracted only the measurements on the mean and standard deviation for each measurement.
* Appropriately labeled the data set with descriptive variable names.
* Created a second, independent tidy data set with the average of each variable for each activity and each subject.
*	Final_tidydataset.txt is the exported final data after going through all the sequences described above.

# description
Tidy data contains 180 rows and 88 columns. Each row has averaged variables for each subject and each activity.
