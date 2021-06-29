#Random Forest
rm(list=ls())
dev.off()
#install.packages("randomForest")
#install.packages("caret")
library(randomForest)
library(caret)
data(iris)
set.seed(123)
indT <- createDataPartition(y=iris$Species, p=0.6, list=FALSE)
training <- iris[indT,]
testing <- iris[-indT,]

#Build Random Forest Model

ModFit_rf <- train(Species~.,data=training,method="rf",prox=TRUE)
#rf = random forest

predict_rf <- predict(ModFit_rf,testing)
confusionMatrix(predict_rf, testing$Species)

testing$PredRight <- predict_rf==testing$Species
ggplot(testing,aes(x=Petal.Width,y=Petal.Length))+
  geom_point(aes(col=PredRight))