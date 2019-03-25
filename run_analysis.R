# Getting and Cleaning Data Course Project
# Author: Horacio Chacón-Torrico
# Date: 24/03/2019

# Libraries and Workind directory

library(tidyverse)
setwd("~/Documents/GitHub/datasciencecoursera/datasciencecoursera/Getting-Cleaning-data/Assignment")

# Step 1. Merges the training and the test sets to create one data set.

## Reading data (Data and Train sets with their id and activity data sets)

test     <- read.table("data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
idtest   <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
acttest  <- read.table("data/UCI HAR Dataset/test/y_test.txt")
train    <- read.table("data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
idtrain  <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
acttrain <- read.table("data/UCI HAR Dataset/train/y_train.txt")

lookup   <- read.table("data/UCI HAR Dataset/activity_labels.txt")

## Adding the subject Id and activity

test    <- test %>% mutate(id = idtest[,1], act = acttest[,1])
train   <- train %>% mutate(id = idtrain[,1], act = acttrain[,1])
 
## Merging Data Frames

merged <- bind_rows(test,train)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Column Name assignment

merged <- merged %>% 
    rename_at(vars(V1:V561), 
              funs(read.table("data/UCI HAR Dataset/features.txt")[,2]))

## Select mean and sd Measurements

merged <- merged[,grep("id|act|[Mm]ean[(][)]|[sD]td[(][)]", names(merged),value = TRUE)]

# Step 3. Uses descriptive activity names to name the activities in the data set

## Replacement of activity labels

wearableMeasurements <- merge(merged,lookup, by.x = "act", by.y = "V1") %>% 
    rename(activity = V2) %>%
    select(id,activity,everything()) %>% select(-act) %>% 
    arrange(id, activity)

rm(list=setdiff(ls(), "wearableMeasurements"))

# Step 4. Appropriately labels the data set with descriptive variable names.

## Variable Names clarification

names <- names(wearableMeasurements)
names <- sub("Acc","Acceleration",names)
names <- sub("[-]mean[(][)][-]|[-]mean[(][)]","Mean",names)
names <- sub("[-]std[(][)][-]|[-]std[(][)]","Std",names)

colnames(wearableMeasurements) <- names ; rm(names)

# Step 5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.

wearableTidy <- wearableMeasurements %>% 
    gather(key = "measurements", value = "value", -(id:activity)) %>% 
    group_by(id, activity, measurements) %>% 
    summarise(average = mean(value, na.rm = TRUE))

# Saving the data sets

write.csv(wearableMeasurements,"output/wearableMeasurements.csv")
write.csv(wearableTidy,"output/wearableTidy.csv",row.names = FALSE)










