This process requires only one R-script (run_analysis.R) and the two user actions below

1) Call the main() function
2) Enter path to the dataset

During the process the following actions are performed

1) The workspace is cleaned by removing all objects
2) The working directory is set to the path entered by the user
3) All required packages are loaded/installed
4) The datasets are merged
	4.1) All files are read
	4.2) Some columns are renamed
	4.3) Some values are added manually
	4.4) A number is added to column names to prevent duplicate column names
5) Only the required columns are selected
6) The dataset is grouped by Activity and subject
7) The workspace is cleared