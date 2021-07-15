# EVALUATION METRICS WITH CARET
rm(list=ls())


# I) CONTINUOUS OUTPUT (Regression)

cor(prediction, testing) # correlation 
cor.test(prediction, testion) # R2

postResample(prediction, testing$Ozone) #RMSE or MSW

# II) CATEGORICAL OUTPUT (Classification models)

confusionMatrix(prediction, testing) #Confusion matrix


#Examples:
# I) Continuous output :
data(airquality)
head(airquality) # Continuous  -> corr or r2 to measure

#II) Categorical output:
data(iris)
head(iris) # output "Species" is categorical -> use classification -> measure with Confusion Matrix

# For each:
# 1. Do pre-processing (visualize feautures importance, deal with missing values), 
# 2. Split into train and test
# 3. Use metrics

#I) iris
#1. Pre-process
library(GGally)
ggpairs(data=iris,aes(colour=Species))
# interpretation: petal.width is the most helpful criteria, and sepal.width the less helpful
is.na.data.frame(iris) # There are no missing values

#2. split:
set.seed(123)
ind1 <- createDataPartition(y=iris$Species, p=0.6, list=F) #p=0.6 : 60% for training
training <- iris[ind1,]
testing <- iris[-ind1,]
head(ind1, 10)

confusionMatrix(prediction, testing)
# https://www.analyticsvidhya.com/blog/2020/04/confusion-matrix-machine-learning/
