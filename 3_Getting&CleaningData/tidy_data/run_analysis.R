# Below is what this script does
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

# load packages data.table and reshape2
if (!require("pacman")) {
    install.packages("pacman")
}
pacman::p_load(data.table, reshape2, gsubfn)

# get data from zip file
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "data.zip"))
unzip(zipfile = "data.zip")

# load activity_labels and features
activityLabels <- fread(
    file.path(path, "UCI HAR Dataset/activity_labels.txt"),
    col.names = c("classLabels", "activityNames")
)

features <-fread(
        file.path(path, "/UCI HAR Dataset/features.txt"),
        col.names = c("index", "featureNames")
    )

# extracting mean and std from features
featuresNeeded <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresNeeded, featureNames]
measurements <- gsubfn(
    "(^t|^f|Acc|Gyro|Mag|BodyBody|\\(\\))",
    list(
        "t" = "Time",
        "f" = "Frequency",
        "Acc" = "Accelerometer",
        "Gyro" = "Gyroscope",
        "Mag" = "Magnitude",
        "BodyBody" = "Body",
        "()" = ""
    ),
    measurements
)
# load train data
## read in train, filtering based on features needed, using with=False to retain data.frame class
train <- fread(file.path(path, "/UCI HAR Dataset/train/X_train.txt"))[, featuresNeeded, with = FALSE]
setnames(train, colnames(train), measurements) # change column name based on measurement

activityTrain <-
    fread(file.path(path, "/UCI HAR Dataset/train/y_train.txt"),
          col.names = "Activity")
subjectTrain <-
    fread(file.path(path, "/UCI HAR Dataset/train/subject_train.txt"),
          col.names = "SubjectNo.")

train <- cbind(activityTrain, subjectTrain, train) # bind all columns together

# load test data
test <- fread(file.path(path, "/UCI HAR Dataset/test/X_test.txt"))[, featuresNeeded, with = FALSE]
setnames(test, colnames(test), measurements)

activityTest <-
    fread(file.path(path, "/UCI HAR Dataset/test/y_test.txt"),
          col.names = "Activity")
subjectTest <-
    fread(file.path(path, "/UCI HAR Dataset/test/subject_test.txt"),
          col.names = "SubjectNo.")

test <- cbind(activityTest, subjectTest, test) 

# merge test and train by rows
testTrain <- rbind(train, test)

# factor Activity column based on activity labels
# use factor() to set own levels and labels
testTrain[["Activity"]] <- factor(testTrain[, Activity]
                                  , levels = activityLabels[["classLabels"]]
                                  , labels = activityLabels[["activityNames"]]
                                  )
# as.factor() to create turn subject numbers into factors
testTrain[["SubjectNo."]] <- as.factor(testTrain[, SubjectNo.])

# melt then cast the data table
testTrain <- melt.data.table(testTrain, id=c("SubjectNo.", "Activity")) # melt down to variable & value
testTrain <- dcast(testTrain, SubjectNo. + Activity ~ variable, mean) # average of SubjectNo & Activity

# write final tidy data into new file
fwrite(testTrain, file="tidyData.txt")
