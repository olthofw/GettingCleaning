Run_analysis.R

In this document the actions performed on the data are explained. The actions lead to a cleaned dataset with an average value grouped by activity and subset. The R-script contains several functions which are called from the main function. To run the entire script only one call to the main function is required. 
A description of all the functions and variables is provided below.

1)	Function: main()
Removes all objects from the workspace. Calls all other functions
Variables
dataMerged: 
a merged dataset.
measurementsExtracted: 
a dataset with extracted measurements.
tableOfAverages: 
Averages grouped by activity and subject.

2)	Function: loadPackages()
Loads required packages and install if not already installed.

3)	Function: getFileX()
Returns list of text-files with “X_” in the name.


4)	Function: getFileY()
Returns list of text-files with “Y_” in the name.

5)	Funtion: getFeatues()
Returns list of text-files containing features

6)	Function: getActivityLabels()
Returns text-file with activity labels

7)	Function: getSubjects()
Returns text-file containing subjects

8)	Function: mergeFiles()
Merges all files. 
Variables
dataTrainX:
Loads training data X
dataTestX:
Loads test data X
dataTrainY:
Loads training data Y
dataTestY:
Loads test data Y
dataSubjectsTrain:
Load subjects training data
dataSubjectsTest:
Loads subjects test data

9)	Function: extractMeasurements()
Selects columns containing standard deviation and mean values and addition the columns Activity, type and subject.
Variables
extractedData:
Dataset containing selected columns

10)	Function: createAverageTable()
Returns dataset grouped by Activity and Subjects.

11)	Function: setWorkingDirectory()
Set working directory to path entered by user
12)	Function: removeObjects()
Remove all objects from workspace except the extracted measurements and the average table