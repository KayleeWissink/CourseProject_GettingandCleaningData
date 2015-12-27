# CourseProject_GettingandCleaningData 

##Prerequisites
1. Store data and set working directory to the folder location of the data
2. load plyr library

##Step 1: load data. 
Set the directory. Use paste function to load file and then read.table command
Do this for the following files:
1. X_train.txt. Stored in train_x variable
2. X_test.txt. Stored in test_x variable
3. Y_train.txt. Stored in train_y variable
4. Y_test.txt. Stored in test_y variable
5. subject.train.txt. Stored in train_subject variable
6. subject_test.txt. Stored in test_subject variable
7. features.txt. Stored in features variable
8. activity_labels.txt. Stored in activity_labels variable

##Step 2: Merge Data
1. First merge together the training data using cbind. Stored in training_data variable
2. Then merge together the test data using cbind. Stored in test_data variable
3. Merge test and training data together using rbind. Stored in final_data variable
4. Add subject and activityid columns to labels of the data from previous step (merging test and training data). Updated final_data variable

##Step 3: Gather only measurements with mean or std deviation
1. use grepl function to gather columns that contain mean or std. Stored in data_mean_and_std variable
2. Also, put subject and activityid as part of the OR values so they are not lost!!

##Step 4: Descriptive Activity Names
1. using join from plyr package, join data with activity labels data, going by ActivityID. Update data_mean_and_std variable

##Step 5: Label data with descriptive labels
1. Use the gsub command to replace all matches. In all cases, we are udpating the data_mean_and_std variable
2. first remove parentheses
3. change Freq to Frequency
4. change the first letter if t to Time
5. change the first letter if f to Frequency
6. Change acc to Acceleration
7. Change Gyro to AngularVelocity
8. CHange Mag to Magnitude
9. Change std to Standard Deviation

##Step 6: Create second, independent tidy data set
1. use ddply to apply the mean function to each subejct and activity name combination. Store in data_average variable
2. Hint: there are 30 subjects and 6 different activityIDs, meaning 180 rows of data
3. write the file to local location
