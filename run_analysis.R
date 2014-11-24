## Get Data from unzipped directory and return a named list of all the required DF
getDataFromDir <- function(dir="UCI HAR Dataset") {
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt")  ## uppercase X
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")  ## lowercase y
  s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  X_train <- read.table("UCI HAR Dataset/train/X_train.txt")  ## uppercase X
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")  ## lowercase y
  s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  
  features <- read.table("UCI HAR Dataset/features.txt")
  activity <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  list("X_test" = X_test, "y_test"=y_test, "s_test"=s_test, "X_train"=X_train, "y_train"=y_train, "s_train"=s_train, 
       "features"=features, "activity"=activity)
  
}

## return a DF with only the *mean() and *std() features
getMeanSD <- function(DF) {
  DF[,grepl("mean()", colnames(DF), fixed=TRUE) | grepl("std()", colnames(DF), fixed=TRUE) | grepl("source", colnames(DF), fixed=TRUE)]
}

## Merge the same-length DF1 and DF2 (assuming their order is identical)
mergeDataFrames <- function (DF1, DF2) {
  
  if (nrow(DF1) != nrow(DF2)) {
    stop ("the two dataframes do not have the same length, exiting...")
  }
  
  # adding an index in the two data frames, which we'll use to merge the data
  DF1 <- cbind(DF1, "DF1_idx" = 1:nrow(DF1))
  DF2 <- cbind(DF2, "DF2_idx" = 1:nrow(DF2))
  
  DFres <- merge(DF1, DF2, by.x = "DF1_idx", by.y = "DF2_idx")
  
  ## suppress the DF1_idx column
  DFres <- DFres[, !(names(DFres) %in% c("DF1_idx"))]
  
  DFres
}

## main analysis and transformation function. 
analyseTransformAndSave <- function(data) {
  
  ## Get required data
  data <- getDataFromDir();
  
  ## Merge train and test data. (with an added column to retain the train/test status)
  mergedDF <- rbind(cbind(data$X_test, source = "test"), cbind(data$X_train, source = "train")) # Features
  mergedActivities <- rbind(data$y_test, data$y_train)    # Activities
  mergedSubjects <- rbind(data$s_test, data$s_train)    # Activities
    
  ## Name columns of main datasets from features names
  ## We expect that the features are in the same order as the variable
  colnames(mergedDF) <- data$features$V2
  colnames(mergedActivities) <- c("Activity_id")
  colnames(mergedSubjects) <- c("Subject_id")
  colnames(data$activity) <- c("Activity_id", "Activity_name")
    
  ## retains only the features named *mean()* and *std()*
  mergedDF <- getMeanSD(mergedDF)
    
  ## Merge data with activities (y_*) then subjects (s_*)
  mergedDF <- mergeDataFrames(mergedDF, mergedActivities)
  mergedDF <- mergeDataFrames(mergedDF, mergedSubjects)
  
  ## We may now merge the resulting DF with the activity_labels DF in order to get meaningful names for the activities
  
  mergedDF <- merge(mergedDF, data$activity, by.x="Activity_id", by.y="Activity_id")
}
