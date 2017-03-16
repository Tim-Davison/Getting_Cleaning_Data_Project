## Merge the training and test to create one data set.

library(dplyr)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

## add variable names
variable_names <- read.table("UCI HAR Dataset/features.txt")
variable_names <- variable_names$V2

names(x_train) <- variable_names
names(x_test) <- variable_names  

## add subject and activities columns to test and train datasets

  train_activities <- read.table("UCI HAR Dataset/train/y_train.txt")
  test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")
  train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
  test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
 
x_train2 <- cbind(train_activities, x_train)
  colnames(x_train2)[1] <- "activities"
x_train3 <- cbind(train_subjects, x_train2)
  colnames(x_train3)[1] <- "subjects"

x_test2 <- cbind(test_activities, x_test)
  colnames(x_test2)[1] <- "activities"
x_test3 <- cbind(test_subjects, x_test2)
  colnames(x_test3)[1] <- "subjects"

  ## merge the test and train datasets
  
  merged_test_train <- rbind(x_test3, x_train3)
                             
## Extract only the measurements on the mean and standard deviation 
## for each measurement.

  mean_names <- grep("mean", names(merged_test_train), value = TRUE); 
  Mean_names <- grep("Mean", names(merged_test_train), value = TRUE); 
  sd_names <- grep("std", names(merged_test_train), value = TRUE); 

  all_names <- c("subjects", "activities", mean_names, Mean_names, sd_names)
  merged_sd_mean <- merged_test_train[all_names]
  
## Use descriptive activity names to name the activities in the data set

  merged_activities <- merged_sd_mean %>% 
          arrange(activities) %>%
          mutate(activities = as.character(factor(activities, levels=1:6,
                 labels= c("walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying"))))
  
## Appropriately label the data set with descriptive variable names.

  names(merged_activities) <- tolower(names(merged_activities))
  names(merged_activities) <- gsub("-", ".", names(merged_activities))
  names(merged_activities) <- gsub("\\()", "", names(merged_activities))
  names(merged_activities) <- gsub("tbodyacc", "body.acceleration.time", names(merged_activities))
  names(merged_activities) <- gsub("tgravityacc", "gravity.acceleration.time", names(merged_activities))
  names(merged_activities) <- gsub("tbodygyro", "body.gyroscope.time", names(merged_activities))
  names(merged_activities) <- gsub("fbodyacc", "body.acceleration.frequency", names(merged_activities))
  names(merged_activities) <- gsub("fbodygyro", "body.gyroscope.frequency", names(merged_activities))
  names(merged_activities) <- gsub("fbodybodyaccjerkmag", "body.acceleration.jerk.magnitude", names(merged_activities))
  names(merged_activities) <- gsub("fbodybodygyromag", "body.gyroscope.magnitude", names(merged_activities))
  names(merged_activities) <- gsub("fbodybodygyrojerkmag", "body.gyroscope.jerk.magnitude", names(merged_activities))
  names(merged_activities) <- gsub("\\(", ".", names(merged_activities))
  names(merged_activities) <- gsub("\\)", "", names(merged_activities))
  names(merged_activities) <- gsub(",", ".", names(merged_activities))
  names(merged_activities) <- gsub("gravitymean", "gravity.mean", names(merged_activities))
  names(merged_activities) <- gsub("timemean", "time.mean", names(merged_activities))
  names(merged_activities) <- gsub("timejerkmean", "time.jerk.mean", names(merged_activities))
  names(merged_activities) <- gsub("timejerkmag", "time.jerk.magnitude", names(merged_activities))
  names(merged_activities) <- gsub("timejerk", "time.jerk", names(merged_activities))
  names(merged_activities) <- gsub("timemag", "time.magnitude", names(merged_activities))
  names(merged_activities) <- gsub("meanfreq", "mean.frequency", names(merged_activities))
  names(merged_activities) <- gsub("frequencyjerk", "frequency.jerk", names(merged_activities))
  names(merged_activities) <- gsub("frequencymag", "frequency.magnitude", names(merged_activities))
  
## Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.
  
  summary_data <- group_by(merged_activities, subjects, activities)
  summary_data %>% summarise_all(mean)
     
  write.table(summary_data, file= "cleaning_data.txt", row.names = FALSE)
  
  