# CourseProject_GettingandCleaningData 

##Prerequisites
1. Store data and set working directory to the folder location of the data
2. load plyr library

##Step 1: load data. 
Set the directory. Use paste function to load file and then read.table command
Do this for the following files:
1. X_train.txt
2. X_test.txt
3. Y_train.txt
4. Y_test.txt
5. subject.train.txt
6. subject_test.txt
7. features.txt
8. activity_labels.txt

##Step 2: Merge Data
1. First merge together the training data using cbind
2. Then merge together the test data using cbind
3. Merge test and training data together using rbind
4. Add subject and activityid columns to labels of the data from previous step (merging test and training data)

##Step 3: Gather only measurements with mean or std deviation
1. use grepl function to gather columns that contain mean or std. 
2. Also, put subject and activityid as part of the OR values so they are not lost!!

##Step 4: Descriptive Activity Names
1. using join from plyr package, join data with activity labels data, going by ActivityID

##Step 5: Label data with descriptive labels
1. Use the gsub command to replace all matches
2. first remove parentheses
3. change Freq to Frequency
4. change the first letter if t to Time
5. change the first letter if f to Frequency
6. Change acc to Acceleration
7. Change Gyro to AngularVelocity
8. CHange Mag to Magnitude
9. Change std to Standard Deviation

##Step 6: Create second, independent tidy data set
1. use ddply to apply the mean function to each subejct and activity name combination
2. Hint: there are 30 subjects and 6 different activityIDs, meaning 180 rows of data
3. write the file to local location


