## Codebook - Getting and Cleaning Data

Peer-graded Assignment: Getting and Cleaning Data Course Project - 2019
Student: Horacio Chacón-Torrico

## Study design and data processing

The study data used in this assignment is called "Human Activity Recognition Using Smartphones Data Set" and the complete information can be found in the following [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). It comprises measurements from smartphones accelerometers performed during different activities (walking, standing, laying, etc.) in 30 subjects.

### Collection of the raw data

The data set files are openly accesible and can be found in this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Structure

The structure of the raw data set is described below. 

```s
└── UCI HAR Dataset
   ├── activity_labels.txt*
   ├── features.txt*
   ├── features_info.txt
   ├── README.txt
   ├── test
   │  ├── Inertial Signals
   │  │  ├── body_acc_x_test.txt
   │  │  ├── body_acc_y_test.txt
   │  │  ├── body_acc_z_test.txt
   │  │  ├── body_gyro_x_test.txt
   │  │  ├── body_gyro_y_test.txt
   │  │  ├── body_gyro_z_test.txt
   │  │  ├── total_acc_x_test.txt
   │  │  ├── total_acc_y_test.txt
   │  │  └── total_acc_z_test.txt
   │  ├── subject_test.txt*
   │  ├── X_test.txt*
   │  └── y_test.txt*
   └── train
      ├── Inertial Signals
      │  ├── body_acc_x_train.txt
      │  ├── body_acc_y_train.txt
      │  ├── body_acc_z_train.txt
      │  ├── body_gyro_x_train.txt
      │  ├── body_gyro_y_train.txt
      │  ├── body_gyro_z_train.txt
      │  ├── total_acc_x_train.txt
      │  ├── total_acc_y_train.txt
      │  └── total_acc_z_train.txt
      ├── subject_train.txt*
      ├── X_train.txt*
      └── y_train.txt*
```
Marked with an "*" are the files that are needed for the assignment.

## Creating the tidy datafile

### Guide to create the tidy data file

In order to obtain the tidy data set, the underlying structure and relationships of the files had to be understood. *README.txt* and *features_info.txt* provide a good explanation of the composition of the data set. 

* The measurement data is stored in two separate data sets, a training and a test (this is done to perform machine learning tasks) one:  
    - *X_train.txt*
    - *X_test.txt*
* The measurements column's headers are stored in a separate file called:
    - *features.txt*
* The subjects' specific id were stored in:
    - *subject_train.txt*
    - *subject_test.txt*
* The activity id is and its corresponding look-up table can be found in:
    - *y_test.txt* and *y_train.txt*
    - *activity_labels.txt*

The processing and tidying script is called [run_analysis.R](link). Previous to tidying steps, we have to download the data and unzip it in a corresponding folder, then follow the steps:

1. __Step 1:__ Here all the necessary *\*.txt* files are loaded, id columns are added for every train and test data set. Then the two separate data sets are appended row-wise.
2. __Step 2:__  All variables names coming from *features.txt* rename the previously unnamed (V1:V561) columns with dplyr rename_at function. Right after, I select specific column names that contain the *mean()* or *std()* string using **regular expresions** and grep.
3. __Step 3:__  By the means of a look-up table (*activity_labels.txt*) the activity ids coming from *y_test.txt* and *y_train.txt* are replaced. Intermediary variables and data frames are removed.
4. __Step 4:__  Variable names are formatted in an appropriate way (no non alphanumeric characters). I opted to leave the uppercase letters as they help differentiate columns with several words.
5. __Step 5:__  With a dplyr pipe workflow using gather to convert all measurements in two key-value variables and a group by-summarize statement the tidy data set is obtained.

### Output

1. Procesed data: wearableMeasurements.txt
2. Tidy data:     wearableTidy.txt


## Description of the variables in the wearableTidy.txt file

 - Dimensions of the dataset: 4 columns x 11880 rows
 - Aggregated measurement data per subject and per activity
 - Variables present in the dataset: id, activity, measurement, average

### id
The id variable that uniquely identifies the experiment subjects.

 - Class: integer
 - Values: 1 up to 30
 - Unit of measurement: none

### activity
This variable describes the activity done by the subject while measured.

 - Class: Factor with 6 levels
 - Values: "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS","WALKING_UPSTAIRS" 
 - Unit of measurement: none
 
### measurements
This variable identifies the type of measurement signal the accelerometer gathered

 - Class: Character
 - Values:
    - fBodyAccelerationJerkMeanY
    - fBodyAccelerationJerkMeanZ
    - fBodyAccelerationJerkStdX
    - fBodyAccelerationJerkStdY
    - fBodyAccelerationJerkStdZ
    - fBodyAccelerationMagMean
    - fBodyAccelerationMagStd
    - fBodyAccelerationMeanX
    - fBodyAccelerationMeanY
    - fBodyAccelerationMeanZ
    - fBodyAccelerationStdX
    - fBodyAccelerationStdY
    - fBodyAccelerationStdZ
    - fBodyBodyAccelerationJerkMagMean
    - fBodyBodyAccelerationJerkMagStd
    - fBodyBodyGyroJerkMagMean
    - fBodyBodyGyroJerkMagStd
    - fBodyBodyGyroMagMean
    - fBodyBodyGyroMagStd
    - fBodyGyroMeanX
    - fBodyGyroMeanY
    - fBodyGyroMeanZ
    - fBodyGyroStdX
    - fBodyGyroStdY
    - fBodyGyroStdZ
    - tBodyAccelerationJerkMagMean
    - tBodyAccelerationJerkMagStd
    - tBodyAccelerationJerkMeanX
    - tBodyAccelerationJerkMeanY
    - tBodyAccelerationJerkMeanZ
    - tBodyAccelerationJerkStdX
    - tBodyAccelerationJerkStdY
    - tBodyAccelerationJerkStdZ
    - tBodyAccelerationMagMean
    - tBodyAccelerationMagStd
    - tBodyAccelerationMeanX
    - tBodyAccelerationMeanY
    - tBodyAccelerationMeanZ
    - tBodyAccelerationStdX
    - tBodyAccelerationStdY
    - tBodyAccelerationStdZ
    - tBodyGyroJerkMagMean
    - tBodyGyroJerkMagStd
    - tBodyGyroJerkMeanX
    - tBodyGyroJerkMeanY
    - tBodyGyroJerkMeanZ
    - tBodyGyroJerkStdX
    - tBodyGyroJerkStdY
    - tBodyGyroJerkStdZ
    - tBodyGyroMagMean
    - tBodyGyroMagStd
    - tBodyGyroMeanX
    - tBodyGyroMeanY
    - tBodyGyroMeanZ
    - tBodyGyroStdX
    - tBodyGyroStdY
    - tBodyGyroStdZ
    - tGravityAccelerationMagMean
    - tGravityAccelerationMagStd
    - tGravityAccelerationMeanX
    - tGravityAccelerationMeanY
    - tGravityAccelerationMeanZ
    - tGravityAccelerationStdX
    - tGravityAccelerationStdY
    - tGravityAccelerationStdZ
 - Unit: none
 - Schema: Structured in 4 parts, the first letter refers to the unit of measurement, then the type of measurement (i.e. GravityAcceleration, BodyAcceleration), then the type of estimate (i.e. mean and standard deviation), and finally the last part refers to the spatial axis (X,Y,Z) of the signal.

#### Notes on measurement:
Here we have filtered 68 out of the 561 types of measurement signals that the raw data set collected originaly. We also have changed the string "Acc" for "Acceleration" for better understanding while aggregating the data.

### average
Summarized average for each signal measurement per activity per subject

 - Class: numeric
 - Values: from -0.9976661 to 0.9745087
 - Unit: frequencys(Hz) if measurements starts with "f" and time if it starts with "t"


##Sources

1. Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2) Smartlab - Non-Linear Complex Systems Laboratory


