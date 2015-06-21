---
title: "readme"
author: "IAMGH"
date: "Sunday, June 21, 2015"
output: html_document
---


This repository was created to satisfy the requirements of the Coursera Getting & Cleaning Data Course Project.

It contains:
* readme.md
* codebook.md
* run_analysis.R
* tidydataset.txt
 
The objective was to produce the tidy data set from source data supplied.

Some results from investigating the source data are as follows:

 
> dim(activitynames)
> [1] 6 2
> activitynames
>   V1                 V2
> 1  1            WALKING
> 2  2   WALKING_UPSTAIRS
> 3  3 WALKING_DOWNSTAIRS
> 4  4            SITTING
> 5  5           STANDING
> 6  6             LAYING


> dim(features)
> [1] 561   2
> features[1:6,1:2]
>   V1                V2
> 1  1 tBodyAcc-mean()-X
> 2  2 tBodyAcc-mean()-Y
> 3  3 tBodyAcc-mean()-Z
> 4  4  tBodyAcc-std()-X
> 5  5  tBodyAcc-std()-Y
> 6  6  tBodyAcc-std()-Z

> dim(subject_test)
> [1] 2947    1

> subject_test[1:6,]
> [1] 2 2 2 2 2 2
> library(dplyr)
> summarize(subject_test)
> data frame with 0 columns and 0 rows
> sum(subject_test)
> [1] 38271
> quantile(subject_test[,])
>   0%  25%  50%  75% 100% 
>    2    9   12   18   24 
> table(subject_test)
>   subject_test
>   2   4   9  10  12  13  18  20  24 
>  302 317 288 294 320 327 364 354 381 


   
> dim(y_test)
> [1] 2947    1
> y_test[1:6,]
> [1] 5 5 5 5 5 5
> str(y_test)
> 'data.frame':       2947 obs. of  1 variable:
>  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
> quantile(y_test[,])
>  0%  25%  50%  75% 100% 
>   1    2    4    5    6    
> table(y_test)
> y_test
>   1   2   3   4   5   6 
> 496 471 420 491 532 537 
   
   
> dim(X_test)
> [1] 2947  561
> X_test[1:6,1:4]
>          V1          V2          V3         V4
> 1 0.2571778 -0.02328523 -0.01465376 -0.9384040
> 2 0.2860267 -0.01316336 -0.11908252 -0.9754147
> 3 0.2754848 -0.02605042 -0.11815167 -0.9938190
> 4 0.2702982 -0.03261387 -0.11752018 -0.9947428
> 5 0.2748330 -0.02784779 -0.12952716 -0.9938525
> 6 0.2792199 -0.01862040 -0.11390197 -0.9944552
> str(X_test)
> 'data.frame':	2947 obs. of  561 variables:
>  $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
>  $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
>  $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
>  $ V4  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
>  $ V5  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
>  $ V6  : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
>  $ V7  : num  -0.953 -0.987 -0.994 -0.995 -0.994 ...
>  $ V8  : num  -0.925 -0.968 -0.971 -0.974 -0.966 ...
>  $ V9  : num  -0.674 -0.946 -0.963 -0.969 -0.977 ...
>  $ V10 : num  -0.894 -0.894 -0.939 -0.939 -0.939 ...
>  $ V11 : num  -0.555 -0.555 -0.569 -0.569 -0.561 ...
> ...
>  $ V97 : num  -0.995 -0.998 -1 -1 -1 ...
>  $ V98 : num  -0.997 -0.999 -0.999 -0.999 -1 ...
> $ V99 : num  -0.997 -0.999 -0.999 -0.999 -1 ...
>   [list output truncated]
  
> fieldswithstd<-grep("std",features[,2])
> fieldswithstd
>  [1]   4   5   6  44  45  46  84  85  86 124 125 126 164 165
> [15] 166 202 215 228 241 254 269 270 271 348 349 350 427 428
> [29] 429 504 517 530 543

> grep("std",features[,2],value=TRUE)
>  [1] "tBodyAcc-std()-X"           "tBodyAcc-std()-Y"          
>  [3] "tBodyAcc-std()-Z"           "tGravityAcc-std()-X"       
>  [5] "tGravityAcc-std()-Y"        "tGravityAcc-std()-Z"       
>  [7] "tBodyAccJerk-std()-X"       "tBodyAccJerk-std()-Y"      
>  [9] "tBodyAccJerk-std()-Z"       "tBodyGyro-std()-X"         
> [11] "tBodyGyro-std()-Y"          "tBodyGyro-std()-Z"         
> [13] "tBodyGyroJerk-std()-X"      "tBodyGyroJerk-std()-Y"     
> [15] "tBodyGyroJerk-std()-Z"      "tBodyAccMag-std()"         
> [17] "tGravityAccMag-std()"       "tBodyAccJerkMag-std()"     
> [19] "tBodyGyroMag-std()"         "tBodyGyroJerkMag-std()"    
> [21] "fBodyAcc-std()-X"           "fBodyAcc-std()-Y"          
> [23] "fBodyAcc-std()-Z"           "fBodyAccJerk-std()-X"      
> [25] "fBodyAccJerk-std()-Y"       "fBodyAccJerk-std()-Z"      
> [27] "fBodyGyro-std()-X"          "fBodyGyro-std()-Y"         
> [29] "fBodyGyro-std()-Z"          "fBodyAccMag-std()"         
> [31] "fBodyBodyAccJerkMag-std()"  "fBodyBodyGyroMag-std()"    
> [33] "fBodyBodyGyroJerkMag-std()"




## Acknowledgement
 David Hood's Course Project FAQ and guidance
without which I could not fathom how the files related to each others
(despite being relatively savvy about databases,  keys and normalisation)

 Before loading the files I attempted to investigate them using notepad. 
 Some of the files just produced unintelligible characters,
 while others appeared to be neither fixed width nor to have intelligible 
 field separation, especially features.txt  

 This left me unable to progress for a considerable time.
 I was mystified by how to even import the files into R.
 I had no way of knowing that just using read.table with no parameters
 would cope just fine!
 
 Suffice to say I couldn't even get to step one for a ridiculously long time.