

==Step 1. downloading and unzipping the data
Although I could -should?- have automated these steps (file.download then use of unzip, etc.), I haven't.
Data was downloaded manually, and unzipped in the working directory

==Step 2.
The following operations on the data have been performed :

** importing all the relevant data into a proper structure (I chose a list of all the table I will be using)
"test/X_test.txt" -> all the 561 variables for the 2947 observations of the test DS
"test/y_test.txt" -> the 2947 values of the activity code number
"test/subject_test.txt" -> the 2947 values of the subject code number
"train/X_train.txt"  -> all the 561 variables for the 7352 observations of the train DS
"train/y_train.txt" -> the 7352 values of the activity code number
"train/subject_train.txt" -> the 7352 values of the subject code number
"features.txt" -> the features, aka the 561 variables names studied
"activity_labels.txt" -> the 6 activities, with code and name

** renaming the colname for X_test and X_train values
colnames(data$X_test) <- data$features$V2
