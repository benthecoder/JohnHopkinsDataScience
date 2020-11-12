# Programming Assignment 3: Hospital Quality

## Assignment Instructions

The data for this assignment come from the Hospital Compare web site (http://hospitalcompare.hhs.gov) run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset es- sentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining whether hospitals should be fined for not providing high quality care to patients (see http://goo.gl/jAXFX for some background on this particular topic).

The Hospital Compare web site contains a lot of data and we will only look at a small subset for this assignment. The zip file for this assignment contains three files

* outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
* hospital-data.csv: Contains information about each hospital.
* Hospital_Revised_Flatfiles.pdf: Descriptions of the variables in each file (i.e the code book).

A description of the variables in each of the files is in the included PDF file named Hospital_Revised_Flatfiles.pdf. This document contains information about many other files that are not included with this programming assignment. You will want to focus on the variables for Number 19 (“Outcome of Care Measures.csv”) and Number 11 (“Hospital Data.csv”). You may find it useful to print out this document (at least the pages for Tables 19 and 11) to have next to you while you work on this assignment. In particular, the numbers of the variables for each table indicate column indices in each table (i.e. “Hospital Name” is column 2 in the outcome-of-care-measures.csv file)

More about the assignment here: [ProgAssignment3.pdf](https://d3c33hcgiwev3.cloudfront.net/_2a0d228f9a48b3de85eedf022225fac9_ProgAssignment3.pdf?Expires=1605312000&Signature=V7AtxFiLqLExJBflwVYEWRrBfZroYNHj7Z04zb2yRLVcGxeQL4tKaEAsf5YbNay9LoWtZ8hh-SaEJqVVyfbwzQtUrFqHI-pJdykDSeN68VDE-1QfK4GHQe6ZL9iCUcAt7iFJcdUROjXoVCeeR4Ghs2S5NzIO1V9vHkz~xMwPbQs_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)

Data zip file - [link](https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip) 

## Code 
Code | Instruction |
--- | --- | 

[outcome.R]() | Plot the 30-day mortality rates for heart attack
[best.R]() | Finding the best hospital in a state
[rankhospital.R]() | Ranking hospitals by outcome in a state
[rankall.R]() | Ranking hospitals in all states