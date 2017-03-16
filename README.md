# Getting_Cleaning_Data_Project
Getting and Cleaning Data Week 4 Project

Files included in this repo:

    README.md
  
    Code_Book
  
    run_analysis.R

Description of the data

  The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six   activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

A full description of the experiment is available here: 
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for this study was sourced from:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

With this data, the following steps were taken:
  1. The training and the test sets were merged to create one data set
  
        I read in the test and training data sets. I added the variable names to each.
        I then used cbind to add the activities and subjects columns to test and training
        sets. Finally I merged the two data sets with rbind.
        
  2. The measurements on the mean and standard deviation were extracted for each measurement
        
        I used grep to find variables with "mean", "Mean" and "std". I created a character
        vector of these names plus "activities" and "subjects". I used this all_names variable 
        to subset my data set.
        
  3. Descriptive activity names were used to name the activities in the data set  
  
        I arranged the data set by activity, then used mutate to change the integers 1 to 6 to the 
        descriptive activities: walking, walking upstairs, walking downstairs, sitting, standing, laying.
        
  4. The variable names of the data set were made descriptive and tidy
      
        Tidy variables should be all lower case, and without dots, dashes and white spaces, per the lecture.
        However, this source https://google.github.io/styleguide/Rguide.xml suggests that dots are 
        accpetable to separate words in variables.
        In this case dots were used to separate words for better comprehension.
        I used gsub to make the variable names more descriptive.
      
  5. An independent tidy data set was created showing the average of each variable for each activity and each subject.
        
        I used group_by and summarize_all to apply the mean to each grouping of subject and activity.

Libraries
    dplyr

End

