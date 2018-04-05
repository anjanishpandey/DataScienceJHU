# Code Book

This document describes run_analysis.R script.

The script run_analysis.R has been provided with comments for each step, for easy walk through and understanding. 
The code can be broadly classified into following sections:

a. Download of UCI HAR Zip file and extracting of files.
b. Read the test and train data set from files.
c. Merge test and train data set.
d. Perform Assignments 1 to 5.

## Prerequisite for assignment (downloading, extracting and loading Data)

a. Download the UCI HAR Zip file if it's not already downloaded. 
b. Extract the Zip file under projectdata directory.
c. load the test and train data to subTest/subTrain, XTrain/XTest and YTrain/YTest respectively.
d. collate the test and train data by column and store them in TestData and TrainData.

## Manipulating Data (Assignment 1 to 5)

a. bind the test and train data together and label it as finalDataSet.
b. calculate mean and standard deviation and store in meanObservations and sdObservations list.
c. replace the numerals with the string representing each of the activity stored in the variable (Activities)
d. label each of the variables of the data frame finalDataSet using label featureLabel obtained by reading features.txt file.
e. group finalDataSet and obtain average by summarizing the finalDataSet and store the data set as finalAverageDataSet. 
   
The finalAverageDataSet looks as below:

> str(finalAverageDataSet)

Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  68 variables:

 $ Volunteers                 : int  1 1 1 1 1 1 2 2 2 2 ...  

 $ Activities                 : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...

 $ tBodyAcc-mean()-X          : num  0.222 0.261 0.279 0.277 0.289 ...

 $ tBodyAcc-mean()-Y          : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...

 $ tBodyAcc-mean()-Z          : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...

 $ tBodyAcc-std()-X           : num  -0.928 -0.977 -0.996 -0.284 0.03 ...

 $ tBodyAcc-std()-Y           : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...

 $ tBodyAcc-std()-Z           : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...

 $ tGravityAcc-mean()-X       : num  -0.249 0.832 0.943 0.935 0.932 ...

 $ tGravityAcc-mean()-Y       : num  0.706 0.204 -0.273 -0.282 -0.267 ...