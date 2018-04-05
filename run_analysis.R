main <- function(){
  
  ## MAIN FUNCTION 
  ## Clear workspace
  rm(list = ls(all = TRUE))
  
  ## Set working directory
  setWorkingDirectory()
  
  ## Load required packages
  loadPackages()
  
  ## Start processing
  dataMerged <- mergeFiles(getFileX(getwd(), "train"), getFileY(getwd(), "train"), getFileX(getwd(), "test"), getFileY(getwd(), "test"), getFeatures(getwd(), "features"), getActivityLabels(getwd()), getSubjects(getwd(), "train"), getSubjects(getwd(), "test"))
  
  measurementsExtracted <- extractMeasurements(dataMerged)
  tableOfAverages <- createAverageTable(measurementsExtracted)
  removeObjects()
  print(dim(tableOfAverages))
}

loadPackages <- function(){
  
  ## Load required packages
  print("Loading packages")
  
  if("data.table" %in% rownames(installed.packages()) == FALSE){
    install.packages('data.table')
  }
  if("dplyr" %in% rownames(installed.packages()) == FALSE){
    install.packages('dplyr')
  }
  if("plyr" %in% rownames(installed.packages()) == FALSE){
    install.packages('plyr')
  }
  require(data.table, quietly = TRUE)
  require(dplyr, quietly = TRUE)
  require(plyr, quietly = TRUE)
}

getFileX <- function(path, type){
  
  ## Get files containing measurements
  return(list.files(path, pattern=paste("X_", type, ".txt", sep=""), recursive = TRUE, full.names = TRUE))
}

getFileY <- function(path, type){
  
  ## Get files containing measurements
  return(paste(path, "/", type, "/y_", type, ".txt", sep=""))
}

getFeatures <- function(path ,features){
  
  ## Get files containing features
  return(list.files(path, pattern=paste(features, ".txt", sep=""), recursive = TRUE, full.names = TRUE))
}

getActivityLabels <- function(path){
    
  ## Get files containing activity labels
  return(paste(path, "/activity_labels.txt", sep=""))
}

getSubjects <- function(path, type){
  
  ## Get files containing measurements
  return(paste(path, "/", type, "/subject_", type, ".txt", sep=""))
}
mergeFiles <- function(fileTrainX, fileTrainY, fileTestX, fileTestY, features, activityLabels, subjectsTrain, subjectsTest){
    
    ## STEP 1: MERGE FILES
    ## Load text-files
    print("Merging files")
    dataTrainX <- read.table(fileTrainX, sep="")
    dataTestX <- read.table(fileTestX, sep="")
    dataTrainY <- read.table(fileTrainY, sep="")
    dataTestY <- read.table(fileTestY, sep="")
    dataSubjectsTrain <- read.table(subjectsTrain, sep="")
    dataSubjectsTest <- read.table(subjectsTest, sep="")
    
    featureLabels <- read.table(features, sep="")
    activityLabels <- read.table(activityLabels, sep="")
    
    names(dataSubjectsTrain)[names(dataSubjectsTrain) == "V1"] <- "subject"
    names(dataSubjectsTest)[names(dataSubjectsTest) == "V1"] <- "subject"
    
    ## Merge text-files
    dataTrainTotal <- cbind(dataTrainY, dataTrainX, dataSubjectsTrain)
    dataTrainTotal$type <- "train"
    
    ##print(head(dataTrainTotal))
    dataTestTotal <- cbind(dataTestY, dataTestX, dataSubjectsTest)
    dataTestTotal$type <- "test"

    dataTotal <- rbind(dataTrainTotal, dataTestTotal)
    
    ## Rename columns. Add the number i to the name to prevent duplicate column names
    names(dataTotal)[1] <- "Activity" ## First column is activity
    
    for(i in 1:561){
      names(dataTotal)[names(dataTotal) == paste("V", i, sep="")] <- as.character(paste(featureLabels$V2[i], i, sep=""))
    }
    
    ## Replace activity number with activity labels
    for(i in 1:6){
      dataTotal$Activity[dataTotal$Activity == i] <- as.character(activityLabels$V2[i])
    }
    return(dataTotal)
}

extractMeasurements <- function(data){
  
  ## STEP 2: Extract only columns containing means and standard deviation
  print("Extracting measurements")
  extractedData <- data %>% select(contains("mean"), contains("std"), contains("Activity"), contains("type"),  contains("subject"))
  return(extractedData)
}

createAverageTable <- function(data){
  
    ## Group by
    print("Creating Average Table")
    return(group_by(as.data.table(data, data$Activity, data$subset)))
}

setWorkingDirectory <- function(){
  
  ## Set working directory
  WD <- readline(prompt="Set your working directory (path to 'UCI HAR Dataset'):")
  setwd(WD)
  print(paste("Working directory set to: ", getwd()), sep="")
}

removeObjects <- function(){
  
  ## Remove all objects except two end results
  rm(list=setdiff(ls(), c("measurementsExtracted", "tableOfAverages")))
}