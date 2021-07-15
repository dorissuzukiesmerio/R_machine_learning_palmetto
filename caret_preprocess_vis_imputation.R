# Intro to CARET package:

#### Installation###
install.packages("caret", dependencies = c("Depends", "Suggests"))
library(caret)

###Pre-processing###

#Visualizing important variables:
library(GGally)
ggpairs(data=iris,aes(colour=Species))

#Missing value:

#method 1: omit missing values
data("airquality") # Here we use this sample data because it contains missing value
new_airquality1 <- na.omit(airquality)

#method 2: set NA to mean value
NA2mean <- function(x) replace(x, is.na(x), mean(x, na.rm = TRUE))
new_airquality2 <-replace(airquality, TRUE, lapply(airquality, NA2mean))

#method 3: Impute

# Impute with Bootstrap Aggregation Imputation (bagimpute)
library(caret)
PreImputeBag <- preProcess(airquality,method="bagImpute")
DataImputeBag <- predict(PreImputeBag,airquality)

# Impute with K-Nearest Neighbour (KNN)
MData <- airquality[,-c(1,5,6)]
PreImputeKNN <- preProcess(MData,method="knnImpute",k=5)
DataImputeKNN <- predict(PreImputeKNN,MData)

#Convert back to original scale
RescaleDataM <- t(t(DataImputeKNN)*PreImputeKNN$std+PreImputeKNN$mean)
