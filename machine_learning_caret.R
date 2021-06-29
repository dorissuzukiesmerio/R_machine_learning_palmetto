#install.packages("caret")
#install.packages("GGally")
#install.packages("RANN")

library(caret)
library(GGally)
library(ggplot2)
library(RANN)
#datasets are built in R: iris and airquality

rm=(list=ls())
dev.off #to clean the plots/images
ggpairs(data=iris,aes(colour=Species)) # visualize 

#Missing Data
#NA 
#NaN, Infinite, oddnumbers(in this case, better to treat in excel = blank )

data("airquality")

#Omit
new_airquality1 <-na.omit(airquality)

#Set NA to mean/min/max/const value
#detects the index that has the NA values

NA2mean <- function(x), replace(x, is.na(x), mean(x, na.rm=TRUE))
new_airquality2 <- replace(airquality, TRUE, lapply(airquality, NA2mean))

#now, based on caret
#1. Preprocess, 2.Impute
PreImputeBag <- preProcess(airquality, method = "bagImpute") #build model with choosen method
DataImputeBag <- predict(PreImputeBag, airquality) # impute

#obs: bag takes random from sampling and imputes

MData <- airquality[,-c(1,5,6)] #exclude (since we don't need)
MData <- airquality[,c(2:4)] #which include (equivalent, two ways of saying)
#we don't need day and month. And KNN would standardize

PreImputeKNN <- preProcess(MData, method="knnImpute", k=5)
DataImputeKNN <- predict(PreImputeKNN, airquality)
#KNN does standardization, so if we want to reescale:
#Convert back to original scale
RescaleDataM <- t(t(DataImputeKNN)*PreImputeKNN$std+PreImputeKNN$mean)