##  Create one R script called run_analysis.R that does the following. 

## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## R version 3.1
## Windows 8.1
## 15/06/2015 Data sourced from here:
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Description of data given here:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## The downloaded file was unzipped into a directory "../Project"
## then the top directory renamed from "UCI HAR Dataset" to "Dataset"
## The user will need to set their local working directory
## as here

setwd("C:/Data/Ivor/Docs/CPD/DataScience/Data/Project")
if(!file.exists("./Dataset")){download.file(fileurl, destfile = "project.zip")
                            unzip("project.zip" )
                            ## dir.rename("./UCI HAR Dataset","./Dataset")
                            }

## Embarrassingly I still haven't worked out how to 
## rename a directory from inside R code, so I couldn't 
##  use something like the next line :
## mv("./UCI HAR Dataset", "./Dataset")
## and instead gave the simpler name manually

## Load the names of the activities
activitynames<- read.table("Dataset/activity_labels.txt")

## Load the names of the X_test.txt file columns
features<- read.table("Dataset/features.txt")

## These are the subjects corresponding to each row in X_test.txt
subject_test<- read.table("Dataset/test/subject_test.txt")

## These are the activities corresponding to each row in X_test.txt
y_test<- read.table("Dataset/test/y_test.txt")

## Load the variables dataset calculated from the raw data
X_test<- read.table("Dataset/test/X_test.txt")

## Start to tidy data in activitynames
activitynames$V3<-tolower(activitynames$V2)
activitynames$V3<-sub("_","",activitynames$V3)
activitynames$V3<-factor(activitynames$V3)

## Apply features to X_test to name the variables
## (The 561 observations in features correspond to 
## 561 variables in X_test)
colnames(X_test)<- features[,2]

## Add a column to y_test to give friendly names to 
## the activities  (note this solves instruction 3)
## 3.Give descriptive activity names to the activities in the data set
y_test$activity<- activitynames[y_test[,1],3]


## Add the friendly names to identify the test data activities
## i.e. Add the new activity names column to the test data
## and add the test subjects to the X_test data

testdataset<-cbind(subject_test,y_test$activity,X_test)

## Give the columns friendlier names
## effectively covers 4.Label the data set with descriptive variable names
## except the variable names might still need cleaning of extraneous text and spaces
## and also we could extract a number of variables from the names 
## eg dimension variable X,Y,Z
## eg Type time/frequency
descriptivenames<- c("subject","activity",as.character(features$V2))
colnames(testdataset)<- descriptivenames

## Now do the same for the training dataset
subject_train<- read.table("Dataset/train/subject_train.txt")
y_train<- read.table("Dataset/train/y_train.txt")
X_train<- read.table("Dataset/train/X_train.txt")
colnames(X_train)<- features[,2]
y_train$activity<- activitynames[y_train[,1],3]
trainingdataset<-cbind(subject_train,y_train$activity,X_train)
colnames(trainingdataset)<- descriptivenames


## 1.Merge the training and the test sets to create one data set.

singledataset<-rbind(testdataset,trainingdataset)


## 2.Extract only the measurements on the mean and standard deviation for each measurement.

## How many are there?
## howmanymeanfields<-table(grepl("mean",names(singledataset)))
## howmanystdfields<-table(grepl("std",names(singledataset)))
## howmanymeanfields
## howmanystdfields

## Find which columns contain those measurements
fieldswithmeans<-grep("mean",names(singledataset))
fieldswithstd<-grep("std",names(singledataset))
 
## Create a new datatable containing those column variables
## [alternative might have been to use dplyr select(,contains()) here ]
## The result, meanplusstddata, is the first tidy data set.
newdatasetnames<-names(singledataset)[c(1,2,fieldswithmeans,fieldswithstd)]
meanplusstddata<-singledataset[,newdatasetnames]

## 3.Give descriptive activity names to the activities in the data set
##  This was done above, see
## y_test$activity<- activitynames[y_test[,1],2]


## 4.Label the data set with descriptive variable names
##   Covered in (2) above


## 5. Create a second, independent tidy data set with 
## the average of each variable for each activity and each subject.
## I have gone for a tall thin table of grouped averages here: 

library(dplyr)
library(tidyr)
tbl_meanplusstd <- tbl_df(meanplusstddata)
indytidydata2<- tbl_meanplusstd %>%
       mutate(subject = factor(subject)) %>%
       gather(measure, value, -subject,-activity) %>%
       group_by(subject,activity,measure) %>%
       summarise(average=mean(value)) %>%
       arrange(measure,activity, subject)
       
## We could go much further, doing things like:
## grep() out the "-" "()" and other untidyness
## separate() out:
##     X, Y and Z dimensions
##     body and gravity readings
##     std(), mean(), meanFreq()
##     t and f into time and frequency
##     accelerometer and gyroscope readings
## 
## and so on. This would probably necessitate the creation of 
## more than one final table, so goes beyond the scope of the
## assignment.


## 6. Create a text file of the tidy data set
##  write.table() using row.name=FALSE
write.table(indytidydata2, "tidydataset.txt", row.names=FALSE)

rm(list=ls())
