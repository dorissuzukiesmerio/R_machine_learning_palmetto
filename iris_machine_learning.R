#Machine Learning with Iris Dataset

set.seed(123)
ind1 <- createDataPartition(y=iris$Species,p=0.6,list=F)
training <- iris[ind1,]
testing  <- iris[-ind1,]

#Apply Cross Validation in Caret:
fitControl <- trainControl(method="cv",number=10)
model <- train(Species~.,data=training,
               trControl = fitControl,method="lda")
print(model)
predict_iris <- predict(model,testing)
length(predict_iris)

confusionMatrix(predict_iris,testing$Species)

