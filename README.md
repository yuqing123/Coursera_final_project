#Getting and Cleaning Data Final Project

###Files in this repo:

* README.md
* CodeBook.md
* run_analysis.R 

###How the run_analysis.R works
run_analysis.R merges the training and the test sets to create one data set. It Extracts only the measurements on the mean and standard deviation for each measurement, and uses descriptive activity names and descriptive labels. 

####Step-by-step walkthrough

**Step 1:**

Write a function to replace multiple values in a dataframe, which will be used later

**Step 2:**

Read the features from features.txt, and store feature names

**Step 3:**

Read all the test and training files respectively, use the function mentioned above to replace number values in y_train.txt and y_test.txt to descriptive values, and filter the data using regular expression to keep names with either "mean" or "std" but not "Freq".

**Step 4:**

Combine both train and test files to one ultimate data frame in the form of subject_number, labels, the actual data.


**Step 5:**
Save a separate data file called average_data.txt which contains the average of each variable for each activity and each subject in the previous dataset
