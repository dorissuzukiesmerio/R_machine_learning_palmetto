# LASSO

rm(list=ls())

#install.packages("PerformanceAnalytics")
library(caret)
library(glmnet)
#library(ElemStatLearn)=> available for R package > 3.6.2
prostate=read.csv("https://raw.githubusercontent.com/vuminhtue/Machine-Learning-Python/master/data/prostate_data.csv")
View(prostate) # see column train, where training and testing is split: is TRUE for data for
set.seed(123)
indT <- which(prostate$train==TRUE)
training <- prostate[indT,]
testing  <- prostate[-indT,]

library(PerformanceAnalytics)
chart.Correlation(training[,-10]) #exclude the training column

##LASSO 

cvfit_LASSO    <- cv.glmnet(x,y,alpha=1)
plot(cvfit_LASSO) # interpretation: 7 predictors, 3 predictors

log(cvfit_LASSO$lambda.min) # what is this value
log(cvfit_LASSO$lambda.1se) #

coef(cvfit_LASSO,s=cvfit_LASSO$lambda.min)
coef(cvfit_LASSO,s=cvfit_LASSO$lambda.1se)

#Build LASSO function:
Fit_LASSO <- glmnet(x,y,alpha=1)
plot_glmnet(Fit_LASSO, label=T, xvar="lambda",
            col=1:8, grid.col ='lightgray')

predict_LASSO <- predict(cvfit_LASSO, xtest, x="lambda.1se")
postResample(testing$lpsa, predict_LASSO)

# avoid overfitting by imputing =0 exactly the ones I want
#Reduces number of covariates . Faster, avoid overfitting