# datascienceTidy
Data Cleaning Exercise

This script reads in several data files related to activity tracking data for 30 individuals conduction 6 different activities

The process first loads the classification files for the activities and the measures recorded

The process then loads the training observations and merges information on the activity for the observation and the subject or person it was for.  Only measures of mean or standard deviation are included in the cleansed dataset.

The process is then repeated for the test observations

After both datasets have been prepped, they are combined into a single dataset in order to perform summary statistics

The activity labels are appended to the final dataset through a merge for readability of results

The observations are then summarized by grouping on Activity and Subject and obtaining the mean value for all measures.  The summarized file is outputted as a text file.
