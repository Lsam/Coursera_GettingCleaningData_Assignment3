# Code Book

*These are the operations, analysis and transformations perfomed on the data (manually) downloaded and unzipped from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*

1. I created dataframes from the relevant files
* "test/X_test.txt" -> all the 561 variables for the 2947 observations of the test DS
* "test/y_test.txt" -> the 2947 values of the activity code number
* "test/subject_test.txt" -> the 2947 values of the subject code number
* "train/X_train.txt"  -> all the 561 variables for the 7352 observations of the train DS
* "train/y_train.txt" -> the 7352 values of the activity code number
* "train/subject_train.txt" -> the 7352 values of the subject code number
* "features.txt" -> the features, aka the 561 variables names studied
* "activity_labels.txt" -> the 6 activities, with code and name

2. I merged, as requested, each <ZZZ>_test and <ZZZ>_train into a global dataframe ; I, of course, did that in parallel, in order to keep the ordering in the features files (X_* files), the activities files (y_*) and the subjects files (subject_*); As I expected each X, y  and subject files (both for train and test) to share the same order.
I added a "source" column, initialised either as "train" or "test" to retain the source of the data.

3. I applied the column names from the features.txt file to the X_ (merged) file; Of course, this is only meaningful if the various columns are in the same order as the features.txt list
I also named the data in the y_ files (one column, "Activity_id"); the subject_ files (one column, "Subject_id") and the activity_labels file (two columns, named respectively "Activity_id" and "Activity_name")

4. I jettisoned all the columns but the one having mean() and std() in their name, as requested. I used the grepl function to do so.

5. I merged the features (x_), activities (y_) and subject (subject_) dataframes, using the row number as the common key

6. At this step, I have a result aggregated and transformed dataframe with 10299 observations (2947 tests + 7352 train), each of which having 70 variables :
* the 66 (among the original 561) variables listed in features.txt having either std() or mean() in their name
* a "source" variable : either "test" or "train"
* a "Activity_id" and a "Activity_name" variables related to the activities
* a "Subject_id" variable related to the subject

