#Regularization and Variable Selection
rm(list=ls())

#install.packages("PerformanceAnalytics")
library(caret)
#library(ElemStatLearn)=> available for R package > 3.6.2
prostate=read.csv("https://raw.githubusercontent.com/vuminhtue/Machine-Learning-Python/master/data/prostate_data.csv")
View(prostate) # see column train, where training and testing is split: is TRUE for data for
set.seed(123)
indT <- which(prostate$train==TRUE)
training <- prostate[indT,]
testing  <- prostate[-indT,]

library(PerformanceAnalytics)
chart.Correlation(training[,-10]) #exclude the training column

# Predict using Ridge Regression
#install.packages("glmnet")
#install.packages("pltomo")
library(glmnet)
library(pltomo)

y <- training$lpsa
x <- training[,-c(9,10)]
x <- as.matrix(x) # convert to matrix for Ridge Regression

cvfit_Ridge <- cv.glmnet(x,y,alpha=0)
plot(cvfit_Ridge)
#the smaller MSE, the better
# vertical line is one std 

log(cvfit_Ridge$lambda.min)
log(cvfit_Ridge$lambda.1se)
coef(cvfit_Ridge, s=cvfit_Ridge$lambda.1se)

Fit_Ridge <- glmnet(x,y,alpha=0, standardize = T)

plot_glmnet(Fit_Ridge, label=T, xvar="lambda",
            col=seq(1,8),grid.col='lightgray')

predict_Ridge <- predict(cvfit_Ridge,newx=xtest,s="lambda.1se")
cor.test(predict_Ridge,testing$lpsa)