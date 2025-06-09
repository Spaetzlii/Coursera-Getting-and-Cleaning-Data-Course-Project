# Human Activity Recognition Using Smartphones: Data Cleaning Project

This project demonstrates data cleaning and tidying of the Human Activity Recognition Using Smartphones dataset. 
The dataset includes accelerometer and gyroscope readings from Samsung smartphones, collected as 30 subjects performed six physical activities.

## Repository Contents

* **run_analysis.R** – Main script for data cleaning and transformation  
* **tidy_data_set.txt** – Final tidy dataset: average of each mean/std measurement per subject/activity  
* **CodeBook.md** – Variable definitions and data transformations  
* **README.md** – This file

## How It Works

1. **Loads raw data**: subject IDs, activity labels, measurements  
2. **Merges datasets**, and only keeping mean/std measurements  
3. **Cleans column names** using `janitor::clean_names()`  
4. **Creates tidy dataset**: calculates averages per subject/activity (30 subjects x 6 activities = 180 rows/observations)  
5. **Exports** to `tidy_data_set.txt`

## Reproducibility

To reproduce the results:

1. Download and unzip the [Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
2. Set the `main_path` variable in `run_analysis.R` to the unzipped folder  
3. Install required R packages: `dplyr`, `janitor`  
4. Run the script: `source("run_analysis.R")`
