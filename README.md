# disasterCRVS

Some basic analyses of the overlap between civil registration and vital statistic data and disasters, to be compiled into the background paper on "Disaster statistics and CRVS systems: Background paper on understanding the nexus between disaster-related statistics and civil registration and vital statistics (CRVS) systems". This background paper will be first drafted for the Fourth Global Expert Forum for Producers and Users of Disaster Related Statistics. The event is hosted at the United Nations Conference Center, Economic Commission for Africa, Addis Ababa, Ethiopia and will take place between the 28th October to 1st November 2024.

## Code Structure

There are two main folders in this repository:

- `RCode`: all R scripts are contained in this folder
- `data`: all the input and output data is stored in this folder. 

Note that the majority of the data required as input to this repository is directly extracted and processed from API endpoints, thus the repository hosted on GitHub will not contain anything in the 'data' folder by default.

There are several files that constitute this repository
- `RCode/GetPackages.R`: source this entire file in order to have all the necessary packages installed and loaded into your local environment
- `RCode/Functions.R`: this contains some generally useful functions. Note that almost none of them will be used within this project but they may still be useful in the future
- `RCode/Pacific_CensusSurvey_Analysis.R`: this contains the scripts that have been used to analyse when the most recent census or surveys were carried out in the Pacific Community.
- `RCode/COVID_estat.R`: this file extracts data from eurostat CRVS systems to analyse the influence of COVID-19 on births, deaths and marriages.

