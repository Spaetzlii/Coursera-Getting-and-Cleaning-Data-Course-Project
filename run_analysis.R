library(dplyr)
library(janitor)


# Define paths
main_path <- "C:/Users/S8MTJQ/Desktop/R Coursera/Course 3/Module 4/Project/"
test_path <- paste0(main_path,"Data/test/")
training_path <- paste0(main_path,"Data/train/")


# Load overall data (labels)
activity_labels <- read.table(paste0(main_path,"Data/activity_labels.txt"), header = FALSE) %>%
    rename(activity_id = V1, activity_name = V2)
measurement_labels <- read.table(paste0(main_path,"Data/features.txt"), header = FALSE) %>%
    rename(measurement_id = V1, measurement_name = V2)


# Load test data
subject_test <- read.table(paste0(test_path,"subject_test.txt"), header = FALSE) %>%
    rename(subject_id = V1) %>%
    mutate(observation = row_number()) %>%
    relocate(observation, .before = 1)

activity_test <- read.table(paste0(test_path,"y_test.txt"), header = FALSE) %>%
    rename(activity_id = V1) %>%
    left_join(activity_labels, by = "activity_id") %>%
    mutate(observation = row_number()) %>%
    relocate(observation, .before = 1)

data_test <- read.table(paste0(test_path,"X_test.txt"), header = FALSE) %>% 
    mutate(observation = row_number()) %>%
    left_join(subject_test, by = "observation") %>%
    left_join(activity_test, by = "observation") %>%
    relocate(observation, subject_id, activity_id, activity_name, .before = 1)
colnames(data_test)[5:565] <- measurement_labels$measurement_name


# Load training data
subject_training <- read.table(paste0(training_path,"subject_train.txt"), header = FALSE) %>%
    rename(subject_id = V1) %>%
    mutate(observation = row_number()) %>%
    relocate(observation, .before = 1)

activity_training <- read.table(paste0(training_path,"y_train.txt"), header = FALSE) %>%
    rename(activity_id = V1) %>%
    left_join(activity_labels, by = "activity_id") %>%
    mutate(observation = row_number()) %>%
    relocate(observation, .before = 1)

data_training <- read.table(paste0(training_path,"X_train.txt"), header = FALSE) %>% 
    mutate(observation = row_number()) %>%
    left_join(subject_training, by = "observation") %>%
    left_join(activity_training, by = "observation") %>%
    relocate(observation, subject_id, activity_id, activity_name, .before = 1)
colnames(data_training)[5:565] <- measurement_labels$measurement_name


# Merge test and training data
data_merged <- rbind(data_test,data_training)


# Extracts only the measurements on the mean and standard deviation for each measurement + clean column names
data_merged <- select(data_merged, 1:4, contains("mean()"), contains("std()")) %>%
    clean_names()


# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
data_merged_tidy <- data_merged %>%
    group_by(subject_id, activity_name) %>%
    summarise(across(-c(observation, activity_id), mean, .names = "groupby_mean_{.col}"), .groups = "drop")


#Export tidy data set
write.table(data_merged_tidy, paste0(main_path,"tidy_data_set.txt"), row.names = FALSE)
