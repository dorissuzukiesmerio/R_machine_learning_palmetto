# Build Bagging ML model

rm(list=ls())
dev.off()
#install.packages("caret")
library(caret)
data(iris)
set.seed(123)
indT <- createDataPartition(y=iris$Species, p=0.6, list=FALSE)
training <- iris[indT,]
testing <- iris[-indT,]

ModFit_bag <- train(as.factor(Species) ~ .,data=training,
                    method="treebag",
                    importance=TRUE) 
# convert to factor when using caret
predict_bag <- predict(ModFit_bag,testing)
confusionMatrix(predict_bag, testing$Species)
plot(varImp(ModFit_bag)) # Variable Importance: which variables are more important to pot

