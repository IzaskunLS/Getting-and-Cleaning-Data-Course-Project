################################################################################################################################################
# GETTING AND CLEANING DATA COURSE                                                                                                                  #
################################################################################################################################################

"run_analysis.R" r-script is the course project for Getting and Cleaning Data Coursera Course. The r-script does this steps:
  1. Prepare enviroment:
		- Call libraries
		- Define variables
			- with the work path
			- with the name of the files
  2. Download original data sets
  3. Organize original data sets
		- Load activity and features information
		- Merge testing and training data sets  to create a work data sets
			- Merge testing data set by columns, keeping only variables about mean and standard deviation.
		    - Merge training data set by columns, keeping only variables about mean and standard deviation.
     	- Merge datasets test & train by row and rename column labels
        - Turn activities & subjects columns into factors with activityLabels datas
  4. Create a second, independent tidy data set with the average of each variable for each activity and each subject
        - Organize information by subject & activity factors to analyce
        - Create a tidy data set with the average measures group by  subject and activity
  5. Download the result tidy data set in the file "result_file.txt"
        