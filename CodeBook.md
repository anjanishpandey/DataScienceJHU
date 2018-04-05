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
