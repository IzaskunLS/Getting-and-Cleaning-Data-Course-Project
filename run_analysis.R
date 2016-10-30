#################################################################################################################################################
# Call & descriptive variables we used on the program:                                                                                          #
#     - Librerías                                                                                                                               #
#     - Ficheros a utilizar                                                                                                                     #
#################################################################################################################################################

  # Library calls
  library(reshape2)
  
  library(data.table)
  
  #PC path
  pc_path1 <- "C:/Users/izask/izaskun_r/data cleaning"
  pc_path2 <- "C:/Users/izask/izaskun_r/data cleaning/UCI HAR Dataset" 

  #Download file
  f_download <- "getdata_dataset.zip"
  fileURL    <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "

  #Load files
  f_activityLabels     <- "activity_labels.txt"
  f_features           <- "features.txt"
  f_train              <- "/train/X_train.txt"
  f_trainActivities    <- "/train/Y_train.txt"
  f_trainSubjects      <- "/train/subject_train.txt"
  f_test <- read.table <- "/test/X_test.txt"
  f_testActivities     <- "/test/Y_test.txt"
  f_testSubjects       <- "/test/subject_test.txt"
  f_exit_file          <- "/result_file.txt"
  

#################################################################################################################################################
# Ejecución del programa                                                                                                                        #
#     - Download the original data sets                                                                                                         #
#     - Ficheros a utilizar                                                                                                                     #
#################################################################################################################################################
  
    ## Download and unzip the dataset:
  
    filename <- paste0(pc_path1, "/", f_download)
    if (!file.exists(filename)){
      download.file(fileURL, filename, mode="wb")
    }  
    if (!file.exists(pc_path2)) { 
      unzip(filename, exdir = pc_path1) 
    }
    
    
    ## Load files with activity labels
    filename <- paste0(pc_path2, "/", f_activityLabels)
    t_activityLabels <- read.table(filename)
    
    ## Load files with features
    filename <- paste0(pc_path2, "/", f_features)
    t_features <- read.table(filename)
    
      # Keep labels to identify mean and standard deviation measures
      t_features <- t_features[grep(".*mean.*|.*std.*", t_features[,2]),]
      t_features$V2 <-  gsub('-mean', '_mean', t_features$V2)
      t_features$V2 <-  gsub('-std', '_std', t_features$V2)
      t_features$V2 <-  gsub('-', '_', t_features$V2)
      t_features$V2 <-  gsub('[()]', '', t_features$V2)
      features_searched.names <- t_features[,2]
      
    ## Load and merge by columns the train datasets
      filename <- paste0(pc_path2, f_train)
      t_train <- read.table(filename)
      
      filename <- paste0(pc_path2, f_trainActivities)
      t_trainActivities <- read.table(filename)
      
      filename <- paste0(pc_path2, f_trainSubjects)
      t_trainSubjects <- read.table(filename)
      
      t_train <- cbind(t_trainSubjects, t_trainActivities, t_train)
      
   ## Load and merge by columns the test datasets
      filename <- paste0(pc_path2, f_test)
      t_test  <- read.table(filename)

      filename <- paste0(pc_path2, f_testActivities)
      t_testActivities  <- read.table(filename)

      filename <- paste0(pc_path2, f_testSubjects)
      t_testSubjects  <- read.table(filename)

      filename <- paste0(pc_path2, f_train)
      t_test <- cbind(t_testSubjects, t_testActivities, t_test)
      
      
    ## merge datasets test & train by row and rename column labels
      t_Data <- rbind(t_train, t_test)
      colnames(t_Data) <- c("subject", "activity", features_searched.names)
      
      # turn activities & subjects into factors with activityLabels datas
      t_Data$activity <- factor(t_Data$activity, levels = t_activityLabels[,1], labels = t_activityLabels[,2])
      # turn subjects into factors 
      t_Data$subject <- as.factor(t_Data$subject)
      
      
      # creates a second, independent tidy data set with the average of each variable for each activity and each subject
        #Organize information by subject & activity factors to analyce
        t_Data.melted <- melt(t_Data, id = c("subject", "activity"))
        
        #Create a tidy data set with the average measures 
        t_Data.mean <- dcast(t_Data.melted, subject + activity ~ variable, mean)
        filename <- paste0(pc_path2, f_exit_file)
        write.table(t_Data.mean, filename, row.names = FALSE, quote = FALSE)
        