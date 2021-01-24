## Background

Using devices such as *Jawbone Up*, *Nike FuelBand*, and *Fitbit* it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks.

One thing that people regularly do is quantify how *much* of a particular activity they do, but they rarely quantify *how well they do it*. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website [here](http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har): (see the section on the Weight Lifting Exercise Dataset).

### Data

-   The training data for this project are available [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv)

-   The test data are available [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv)

-   The data for this project come from this [source](http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har)

### Goal

The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should create a report describing how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases

## What you should submit
The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should create a report describing how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases. 

## Peer Review Portion
Your submission for the Peer Review portion should consist of a link to a Github repo with your R markdown and compiled HTML file describing your analysis. Please constrain the text of the writeup to < 2000 words and the number of figures to be less than 5. It will make it easier for the graders if you submit a repo with a gh-pages branch so the HTML page can be viewed online (and you always want to make it easy on graders :-).

## Course Project Prediction Quiz Portion
Apply your machine learning algorithm to the 20 test cases available in the test data above and submit your predictions in appropriate format to the Course Project Prediction Quiz for automated grading. 

## Reproducibility 
Due to security concerns with the exchange of R code, your code will not be run during the evaluation by your classmates. Please be sure that if they download the repo, they will be able to view the compiled HTML version of your analysis. 

---

## Files description
* Figs - plots from prediction diagnostics
* human-activity-prediction.Rmd - rmarkdown file for project
* human-activity-prediction.html - compiled html 
* rfmodel.rds - random forest model saved in rds file for faster knitting

## Executive summary

Using a random forest classifier with a k-fold cross validation of 7, the optimal model has an **accuracy of 0.993** and an OOB rate of **0.66%**. The variable importance plot shows that the roll_belt variable was most important in predicting the `classe` variable.

Applying our model on the test set, we attain a similar **accuracy of 0.993**. Applying the model on the 20 test case in our validation set, we achieve 100% accuracy in predicting the right `classe` variable.
