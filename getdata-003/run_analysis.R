library(plyr)

# NB: there are 561 columns for features but some have repeated names.
# There are only 477 unique feature names!

#
# read the data if you can
#
if (!file.exists("UCI HAR Dataset/activity_labels.txt")) stop ("activity_labels.txt not found!")
if (!file.exists("UCI HAR Dataset/features.txt")) stop ("features.txt not found!")
if (!file.exists("UCI HAR Dataset/test/subject_test.txt")) stop ("subject_test.txt not found!")
if (!file.exists("UCI HAR Dataset/test/X_test.txt")) stop ("UCI HAR Dataset/test/X_test.txt not found!")
if (!file.exists("UCI HAR Dataset/test/y_test.txt")) stop ("UCI HAR Dataset/test/y_test.txt not found!")
if (!file.exists("UCI HAR Dataset/train/subject_train.txt")) stop ("subject_train.txt not found!")
if (!file.exists("UCI HAR Dataset/train/X_train.txt")) stop ("UCI HAR Dataset/train/X_train.txt not found!")
if (!file.exists("UCI HAR Dataset/train/X_train.txt")) stop ("UCI HAR Dataset/train/X_train.txt not found!")

activity_labels <- read.table(file="UCI HAR Dataset/activity_labels.txt", header=FALSE)
features <- read.table(file="UCI HAR Dataset/features.txt", header=FALSE)
subject_test <- read.table(file="UCI HAR Dataset/test/subject_test.txt", header=FALSE)
X_test <- read.table(file="UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test <- read.table(file="UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_train <- read.table(file="UCI HAR Dataset/train/subject_train.txt", header=FALSE)
X_train <- read.table(file="UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train <- read.table(file="UCI HAR Dataset/train/y_train.txt", header=FALSE)


#
# Merge the training and the test sets to create one data set.
#
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)


#
# Extract only the measurements on the mean and standard deviation for each measurement.
#
X_mean = sapply(X, mean)
X_sd = sapply(X, sd)


#
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names.
#
X$activity <- y$V1
X$subject <- factor(subject$V1)


#
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
#
tidyData <- ddply(.data=X, .variables=.(X$activity, X$subject), colwise(mean))
names(tidyData) = c("activity","subject", as.character(features$V2))
rownames(tidyData) <- activity_labels$activity
for (i in 1:(dim(tidyData)[1])) {
    tidyData[i, "activity"] = as.character(activity_labels[tidyData[i, "activity"], 2])
}

#
# Write my output
#
write.table(x=tidyData, file="tidyData.txt", quote=F)
