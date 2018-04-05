if(!file.exists("./projectdata")){dir.create("./projectdata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./projectdata/UCIDataSet.zip", method = "auto", mode = "wb")

#change current working directory to "projectdata"
setwd("./projectdata")

#unzip the file and extract files to projectdata
unzip("UCIDataSet.zip")

#Let's change the current working directory to train
setwd("./UCI HAR Dataset/train")
##Create data frame from set of train data
subTrain <- read.table("subject_train.txt")
XTrain <- read.table("X_train.txt")
YTrain <- read.table("y_train.txt")
#Merge Training data set and label
## Note: first names to column for subTrain, YTrain and XTrain, as 
## all have the first variable named as v1. 
## As subTrain and YTrain has only one column and they represent 
## Volunteers and Activities respectively, let's change the column 
## for subTrain and YTrain to reflect the data, so that it's easy to perform
## operations on data frame and later perform other operation easily.

# Changing Column for subTrain to reflect, it contains Volunteers 
names(subTrain) <- c("Volunteers")

# Changing Column for YTrain to reflect, it contains Volunteers 
names(YTrain) <- c("Activities")

# Now that we have subTrain, XTrain and YTrain with distinctive column names,
# Let's join them to make them meaningful data frame.

#Let's join the XTrain(Labels) with YTrain(Activities)
TrainData <- cbind(YTrain, XTrain)

#Now let's join the Volunteers details to the TrainData frame
TrainData <- cbind(subTrain, TrainData)

#Now Let's repeat the above steps for Test Data

#Let's change the curent working directory to test
setwd("./../test")
##Create data frame from set of test data
subTest <- read.table("subject_test.txt")
XTest <- read.table("X_test.txt")
YTest <- read.table("y_test.txt")

## Note: first names to column for subTest, YTest and XTest, as 
## all have the first variable named as v1. 
## As subTest and YTest has only one column, and they represent 
## Volunteers and Activities respectively, let's change the column 
## for subTest and YTest to reflect the data, so that it's easy to peform
## operations on data frame and perform other operation easily.

# changing Column for subTest to reflect, it contains Volunteers 
names(subTest) <- c("Volunteers")

# changing Column for YTest to reflect, it contains Activities 
names(YTest) <- c("Activities")

# Now that we have subTest, XTest and YTest with distinctive column names,
# Let's join them to make them meaningful data frame.

#Let's join the XTest(Labels) with YTest(Activities)
TestData <- cbind(YTest, XTest)

#Now let's join the Volunteers details to the TestData frame
TestData <- cbind(subTest, TestData)

# Assignment 1 : Merges the training and the test sets to create one data set.
# When we look at the data frame for test data contained in TestData, we find
# that it contains observation for some of the volunteers only. As the 
# observation are same, we should merge the data by row using rbind()

finalDataSet <- rbind(TrainData, TestData)

# Assignment 2 : Extracts only the measurements on the mean and 
#                Standard deviation for each measurement.
# looking at the final data frame, the variables are Volunteers, Activities and 
# the 561 measurements for each of the Volunteers and Activity combinations.
# So, we need to find mean and standard deviation for all the 561 measurement 
# observations.
meanObservations <- lapply(finalDataSet[3:563], mean)
sdObservations <- lapply(finalDataSet[3:563], sd)

# Assignment 3 : Uses descriptive activity names to name the activities 
#                in the data set
# As per README.txt, subjects performed six activities viz., 
# WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
# . The Activities column represent these activities using numerals from 1:6,
# which need to be mapped to the activities names above.
xref <- c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS",
          "4" = "SITTING", "5" = "STANDING", "6" = "LAYING")
finalDataSet$Activities <- sapply(finalDataSet$Activities, function(x) ifelse( x %in% names(xref), 
                                                                               xref[x], as.vector(x)) )

# Assignment 4 : Appropriately labels the data set with descriptive variable names.
# We have already labelled the Volunteers and Activities Variables, we need to
# label all the measurement variables, using variable names stored in 
# features.txt file.
#
#Let's change the curent working directory to dataset root directory
setwd("../")
#let's read the details on 561 features from file features.txt
featureLabelFrame <- read.table("features.txt")
# the feature label is present in factor form, let's convert it to character 
# Vector form
featureLabel <- as.character(featureLabelFrame$V2)
# let's assign the names to variable of finalDataSet, representing measurement
# variable
names(finalDataSet)[3:563] <- featureLabel

meanStdColNamesIndex <- grep("Activities|Volunteers|mean\\(|std\\(", colnames(finalDataSet))

finalDataSet <- finalDataSet[,meanStdColNamesIndex]

# Assignment 5 : From the data set in step 4, creates a second, independent 
#                tidy data set with the average of each variable for each 
#                activity and each subject.
# Basically we need to group the data by two variable (Volunteers and Activities)
# once we have that done, we need to apply the average to the grouped data frame
finalAverageDataSet <- finalDataSet %>% group_by(Volunteers, Activities) %>% 
    summarise_all(funs(mean))

# write the finalAverageDataSet to the output file 
# data_cleaning_assignment_results.csv
if(!file.exists("./output")){dir.create("./output")}
write.csv(finalAverageDataSet, file = "./output/data_cleaning_assignment_results.csv", row.names = FALSE)
