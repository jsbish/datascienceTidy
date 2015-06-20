run_Analysis <- function() {   

    #### Read the decode tables

    #read the Activity list into a dataframe
    activityLabels <- read.table("activity_labels.txt")
    colnames(activityLabels) <- c("ActivityID","Activity")

    #read the Features (or Measures) list into a dataframe
    features <- read.table("features.txt")

    #### Read and process the training data

    setwd("train")

    #read the subject ID for each observation into a dataframe
    trainSubject <- read.table("subject_train.txt")

    #read the activity ID for each observation into a dataframe
    trainActivity <- read.table("y_train.txt")

    #read the training observations into a dataframe
    trainMeasures <- read.table("X_train.txt")

    #transpose the list of Features to be used as column headers
    featuresRow <- t(features[,2])

    #apply the measure names from Features to the columns of the training observations
    colnames(trainMeasures) <- featuresRow

    #remove columns with duplicate column header names 
    trainMeasures2 <- trainMeasures[,-(303:344)]

    #create a new dataframe with only the column header names containing mean
    trainMeasures3 <- select(trainMeasures2,contains("mean"))

    #create a new dataframe with only column header names containing std
    trainMeasures4 <- select(trainMeasures2,contains("std"))

    #combine the two new dataframes into one with mean and std columns

    trainMeasuresFinal <- cbind(trainMeasures3,trainMeasures4)

    #add the subject ID (or person) to trainMeasuresFinal
    trainMeasuresFinal$Subject <- trainSubject$V1

    #add the activity ID to trainMeasuresFinal
    trainMeasuresFinal$ActivityID <- trainActivity$V1

    #### Repeat process for test data
    
    setwd("..\\test")

    #read the subject ID for each training observation into a dataframe
    testSubject <- read.table("subject_test.txt")

    #read the activity ID for each training observation into a dataframe
    testActivity <- read.table("y_test.txt")

    #read the actual Measures for the training observations into a dataframe
    testMeasures <- read.table("X_test.txt")

    #apply the measure names from Features to the columns of the training observations
    colnames(testMeasures) <- featuresRow

    #remove columns with duplicate column header names 
    testMeasures2 <- testMeasures[,-(303:344)]

    #create a new dataframe with only the column header names containing mean
    testMeasures3 <- select(testMeasures2,contains("mean"))

    #create a new dataframe with only column header names containing std
    testMeasures4 <- select(testMeasures2,contains("std"))

    #combine the two new dataframes into one with mean and std columns
    testMeasuresFinal <- cbind(testMeasures3,testMeasures4)

    #add the subject ID (or person) to trainMeasuresFinal
    testMeasuresFinal$Subject <- testSubject$V1

    #add the activity ID to trainMeasuresFinal
    testMeasuresFinal$ActivityID <- testActivity$V1

    #### Combine test and train data

    measuresFinal <- rbind(trainMeasuresFinal, testMeasuresFinal)
    
    #add the Activity label to the final dataset
    measuresFinal <- merge(measuresFinal,activityLabels, by.x="ActivityID", by.y="ActivityID",all=TRUE)

    #### Create the summary dataset
    
    #group by subject and activity and calc mean for all
    measuresSummary <- measuresFinal %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
    
    write.table(measuresSummary, file = "measuresFinal.txt", row.nam = FALSE)
}

    

