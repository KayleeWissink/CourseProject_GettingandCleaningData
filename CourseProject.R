#############################################
##Step 1: Load data into variables
##use Sep = "" for all
##need to load plyr package
#############################################

##set directory variable
file_dir <- "UCI\ HAR\ Dataset"

## X_train.txt
train_file_x <- paste(file_dir, "/train/X_train.txt", sep = "")
train_x <- read.table(train_file_x)

## X_test.txt
test_file_x <- paste(file_dir, "/test/X_test.txt", sep = "")
test_x <- read.table(test_file_x)

## Y_train.txt
train_file_y <- paste(file_dir, "/train/Y_train.txt", sep = "")
train_y <- read.table(train_file_y)

## Y_test.txt
test_file_y <- paste(file_dir, "/test/Y_test.txt", sep = "")
test_y <- read.table(test_file_y)

## subject_train.txt
train_file_subject <- paste(file_dir, "/train/subject_train.txt", sep = "")
train_subject <- read.table(train_file_subject)

## subject_test.txt
test_file_subject <- paste(file_dir, "/test/subject_test.txt", sep = "")
test_subject <- read.table(test_file_subject)

## features.txt. Specify vector of classes to be character
features_file <- paste(file_dir, "/features.txt", sep = "")
features <- read.table(features_file, colClasses = c("character"))

## activity_labels.txt. Set column names to ActivityID and Activity
activity_file <- paste(file_dir, "/activity_labels.txt", sep = "")
activity_labels <- read.table(activity_file, col.names = c("ActivityID", "Activity"))

##############################
##Step 2: Merge Data
##############################

##training data
training_data_temp <- cbind(train_x, train_subject)
training_data <- cbind(training_data_temp, train_y)

##test data
test_data_temp <- cbind(test_x, test_subject)
test_data <- cbind(test_data_temp, test_y)

##Merge together training and test data
final_data <- rbind(training_data, test_data)

##labels
##add subject and activity ID columns to end of dataset, columns 562 and 563
labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityID"))[,2]
names(final_data) <- labels

###############################################
##Step 3: Gather only measurements with mean and std deviation
## use grepl regular expression with or operators. Include subject and activityid so those are not droppped
###############################################
data_mean_and_std <- final_data[,grepl("mean|std|Subject|ActivityID", names(final_data))]

################################################
##Step 4: Descriptive Activity Names. Use activity labels and join by the Activity ID column
## uses join from plyr package
################################################
data_mean_and_std <- join(data_mean_and_std, activity_labels, by = "ActivityID", match = "first")
data_mean_and_std <- data_mean_and_std[,-1]

################################################
##Step 5: Label data with descriptive labels
## use gsub command to replace all matches of expression
################################################

names(data_mean_and_std) <- gsub("\\(|\\)", "", names(data_mean_and_std), perl = TRUE)
names(data_mean_and_std) <- gsub('Freq', 'Frequency', names(data_mean_and_std))
names(data_mean_and_std) <- gsub('^t', 'Time', names(data_mean_and_std))
names(data_mean_and_std) <- gsub('^f', 'Frequency', names(data_mean_and_std))
names(data_mean_and_std) <- gsub('Acc', 'Acceleration', names(data_mean_and_std))
names(data_mean_and_std) <- gsub('Gyro', 'AngularVelocity', names(data_mean_and_std))
names(data_mean_and_std) <- gsub('Mag', 'Magnitude', names(data_mean_and_std))
names(data_mean_and_std) <- gsub('std', 'StandardDeviation', names(data_mean_and_std))

###############################################
##Step 6: creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Use ddply : For each subset of a data frame, apply function then combine results into a data frame.
## use numcolwise to operate column-wise instead of on vector to operate on 30 different subjects with 6 different activity IDs (will computer to 180 rows)
###############################################
data_average <- ddply(data_mean_and_std, c("Subject", "Activity"), numcolwise(mean))
write.table(data_average, file = "data_average_1.txt", row.names = FALSE)
