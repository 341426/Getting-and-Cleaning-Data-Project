## Course Title
### [Getting and Cleaning Data](https://www.coursera.org/#course/getdata) 

### Instructor: [Jeff Leek](http://biostat.jhsph.edu/~jleek/) 

## Data
The project represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of dataset is available at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Code
To prepare tidy data R script called "run_analysis.R" created. 
The scrip do the following.

1. Load row data from working directory.
```r
data.train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
subject.train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
labels.train <- read.table("UCI HAR Dataset\\train\\y_train.txt")
data.test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
subject.test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
labels.test <- read.table("UCI HAR Dataset\\test\\y_test.txt")
data.names <- read.table("UCI HAR Dataset\\features.txt")
activity.labels <- read.table("UCI HAR Dataset\\activity_labels.txt")
```

2. Label tables column.
```r
names(data.train) <- data.names$V2
names(data.test) <- data.names$V2
names(subject.train) <- "subject"
names(subject.test) <- "subject"
names(labels.train) <- "labels"
names(labels.test) <- "labels"
```

3. Add activity and subject to data tables
```r
data.train <- cbind(data.train, subject.train, labels.train)
data.test <- cbind(data.test, subject.test, labels.test)
```

4. Merges the training and the test sets to create one data set.
```r
data <- rbind(data.train, data.test)
```

5. Extracts only the measurements on the mean and standard deviation for each measurement.
```r
data <- data[, c(as.character(data.names$V2[grepl("-mean\\(|-std\\(",data.names$V2)]), 
                 "labels", "subject")]
```

6. Uses descriptive activity names to name the activities in the data set.
 Appropriately labels the data set with descriptive activity names.
```r
data$labels <- as.factor(data$labels)
levels(data$labels) <- activity.labels$V2
```

7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```r
data.aggregate <- aggregate(data, by=list(data$subject, data$labels), mean) 
```

8. Save resulted table to the file x_data.txt to the working directory.
```r
write.table(data.aggregate, "x_aggregate.txt")
```

## Variables in result dataset
Below is the full list of variables in the result data set.

1, 2 - Subject id and Activity that used to aggregate data.

3 - 68 - Average mean and standard deviation of data data collected from the accelerometers.

1. subject
2. activity
3. tBodyAcc-mean()-X	
4. tBodyAcc-mean()-Y	
5. tBodyAcc-mean()-Z	
6. tBodyAcc-std()-X	
7. tBodyAcc-std()-Y	
8. tBodyAcc-std()-Z	
9. tGravityAcc-mean()-X	
10. tGravityAcc-mean()-Y	
11. tGravityAcc-mean()-Z	
12. tGravityAcc-std()-X	
13. tGravityAcc-std()-Y	
14. tGravityAcc-std()-Z	
15. tBodyAccJerk-mean()-X	
16. tBodyAccJerk-mean()-Y	
17. tBodyAccJerk-mean()-Z	
18. tBodyAccJerk-std()-X	
19. tBodyAccJerk-std()-Y	
20. tBodyAccJerk-std()-Z	
21. tBodyGyro-mean()-X	
22. tBodyGyro-mean()-Y	
23. tBodyGyro-mean()-Z	
24. tBodyGyro-std()-X	
25. tBodyGyro-std()-Y	
26. tBodyGyro-std()-Z	
27. tBodyGyroJerk-mean()-X	
28. tBodyGyroJerk-mean()-Y	
29. tBodyGyroJerk-mean()-Z	
30. tBodyGyroJerk-std()-X	
31. tBodyGyroJerk-std()-Y	
32. tBodyGyroJerk-std()-Z	
33. tBodyAccMag-mean()	
34. tBodyAccMag-std()	
35. tGravityAccMag-mean()	
36. tGravityAccMag-std()	
37. tBodyAccJerkMag-mean()	
38. tBodyAccJerkMag-std()	
39. tBodyGyroMag-mean()	
40. tBodyGyroMag-std()	
41. tBodyGyroJerkMag-mean()	
42. tBodyGyroJerkMag-std()	
43. fBodyAcc-mean()-X	
44. fBodyAcc-mean()-Y	
45. fBodyAcc-mean()-Z	
46. fBodyAcc-std()-X	
47. fBodyAcc-std()-Y	
48. fBodyAcc-std()-Z	
49. fBodyAccJerk-mean()-X	
50. fBodyAccJerk-mean()-Y	
51. fBodyAccJerk-mean()-Z	
52. fBodyAccJerk-std()-X	
53. fBodyAccJerk-std()-Y	
54. fBodyAccJerk-std()-Z	
55. fBodyGyro-mean()-X	
56. fBodyGyro-mean()-Y	
57. fBodyGyro-mean()-Z	
58. fBodyGyro-std()-X	
59. fBodyGyro-std()-Y	
60. fBodyGyro-std()-Z	
61. fBodyAccMag-mean()	
62. fBodyAccMag-std()	
63. fBodyBodyAccJerkMag-mean()	
64. fBodyBodyAccJerkMag-std()	
65. fBodyBodyGyroMag-mean()	
66. fBodyBodyGyroMag-std()	
67. fBodyBodyGyroJerkMag-mean()	
68. fBodyBodyGyroJerkMag-std()	