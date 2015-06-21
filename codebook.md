---
title: "Clean data Project Codebook"
author: "IAMGH"
date: "Sunday, June 21, 2015"
output: html_document
---

 
## Project 
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data for the project was sourced here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 
##Creating the tidy datafile
The instructions required:
Create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 
## Variables in the tidydataset.txt
* subject       - the thirty subjects involved in the original study
* activity      - the six activities undertaken by the subjects
* measure       - the various mean and std variables derived from the original data
*  average       - the value of the average for each grouped measure

The names of the measures can be interpreted as follows:
t - denotes time
f - denotes frequency (Fourier transform)
Acc - accelerometer
Gyro - gyroscope
mag - magnitude
X,Y,Z  - denote axis direction
Jerk - derived from acceleration and velocity
