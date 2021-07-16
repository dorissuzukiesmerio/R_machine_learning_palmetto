#Supervised Learning_ PART 2: CATEGORICAL OUTPUT

install.packages(caret)
library(caret)
#Logit : binary 

#Example: spam mail
#Load data
install.packages(kernlab)
library(kernlab)
data(spam)
names(spam)
#Partion:
indTrain <- createDataPartition(y=spam$type,p=0.6,list = FALSE)
training <- spam[indTrain,]
testing  <- spam[-indTrain,]
#train model
ModFit_glm <- train(type~.,data=training,method="glm")
summary(ModFit_glm$finalModel)
#Predict
predictions <- predict(ModFit_glm,testing)
confusionMatrix(predictions, testing$type) #Measure