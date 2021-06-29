# Boosting ML model --> SEQUENCIAL 
#--> different weights

#install.packages("caret")
#install.packages("adabag")
#install.packages("gbm")
library(caret)
library(adabag) # nice plotting tools
library(gbm)
library(rpart)
library(foreach)
library(doParallel)
library(iterators)
library(parallel)

rm(list=ls())
dev.off()

data(iris)
set.seed(123)
indT <- createDataPartition(y=iris$Species, p=0.6, list=FALSE)
training <- iris[indT,]
testing <- iris[-indT,]

#Build Boosting ML model using adaboost:
ModFit_adaboost <- boosting(Species~., data=training, mfinal=10,
                            coeflearn="Breiman")

importanceplot(ModFit_adaboost)

predict_Ada <-predict(ModeFit_adaboost, testing)
confusionMatrix(as.factor(predict_Ada$class), testing$Species) # they have to be same class (check class to see)

#Gradient Boosting Machine ML model
ModFit_GBM <- train(Species~., data=training,
                    method="gbm",
                    verbose=F)


predict_GBM <-predict(ModFit_GBM, testing)# use model ModFit_GBM with testing dataset
confusionMatrix(testing$Species, predict_GBM) # see how predictions did in relation to the actual 