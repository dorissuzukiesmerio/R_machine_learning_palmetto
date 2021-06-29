#Supervised Learning
rm(list=ls())

library(caret)
data(airquality)

set.seed(123)

#Impute missing value using Bagging approach
PreImputeBag <- preProcess(airquality,method="bagImpute")
airquality_imp <- predict(PreImputeBag,airquality)

#Prepare: clean data by imputing missing values
indT <- createDataPartition(y=airquality_imp$Ozone,p=0.6,list=FALSE)
training <- airquality_imp[indT,]
testing  <- airquality_imp[-indT,]

# Single Linear Regression model
ModFit <- train(Ozone~Temp,data=training,
                preProcess=c("center","scale"),
                method="lm")
summary(ModFit$finalModel)

prediction <- predict(ModFit, testing)
postResample(prediction, testing$Ozone)

# Multiple Linear Regression Model

ModFit2 <- train(Ozone~Temp + Solar.R+Wind, data=training,
                 preProcess=c("center","scale"),
                 method="lm")

prediction2 <-predict(ModFit2, testing)
postResample(prediction2,testing$Ozone)

#StepWise Regression Model
ModFit_SLR <- train(Ozone~Temp + Solar.R+Wind, data=training,
                    preProcess=c("center","scale"),
                    method="lmStepAIC")

prediction <- predict(ModFit,testing)
cor.test(prediction,testing$Ozone)
postResample(prediction,testing$Ozone)

postResample(prediction,testing$Ozone)

# Polynomial
modFit_poly <- train(Ozone~poly(Solar.R,3)+poly(Wind,3)+poly(Temp,3),data=training,
                     preProcess=c("center","scale"),
                     method="lm") # 3 is the degrees of freedom we are allowing
summary(modFit_poly$finalModel)
prediction_poly <- predict(modFit_poly,testing)
cor.test(prediction_poly,testing$Ozone)
postResample(prediction_poly,testing$Ozone)

#PCR 
ModFit_PCR <- train(Ozone~Solar.R+Wind+Temp, data=training,
                    preProcess=c("center","scale"),
                    method="pcr")
summary(ModFit_SLR)

prediction_PCR <- predict(ModFit_PCR,testing)

cor.test(prediction_PCR,testing$Ozone)
postResample(prediction_PCR,testing$Ozone)

