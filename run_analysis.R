#Coursera. Getting and Cleaning Data Course Project.
#
# load data
data.train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
subject.train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
labels.train <- read.table("UCI HAR Dataset\\train\\y_train.txt")
data.test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
subject.test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
labels.test <- read.table("UCI HAR Dataset\\test\\y_test.txt")
data.names <- read.table("UCI HAR Dataset\\features.txt")
activity.labels <- read.table("UCI HAR Dataset\\activity_labels.txt")
# set column names
names(data.train) <- data.names$V2
names(data.test) <- data.names$V2
names(subject.train) <- "subject"
names(subject.test) <- "subject"
names(labels.train) <- "labels"
names(labels.test) <- "labels"
# Mergesactivity, subject and data 
data.train <- cbind(data.train, subject.train, labels.train)
data.test <- cbind(data.test, subject.test, labels.test)
# Merges the training and the test sets to create one data set.
data <- rbind(data.train, data.test)
# Extracts only the measurements on the mean and standard deviation for each measurement.
data <- data[, c(as.character(data.names$V2[grepl("-mean\\(|-std\\(",data.names$V2)]), 
                 "labels", "subject")]
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names.
data$labels <- as.factor(data$labels)
levels(data$labels) <- activity.labels$V2
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
data.aggregate <- aggregate(data, by=list(data$subject, data$labels), mean) 
write.table(data.aggregate, "x_aggregate.txt")
