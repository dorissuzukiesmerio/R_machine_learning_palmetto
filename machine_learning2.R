rm(list=ls())
dev.off()

library(caret)
data(iris)
set.seed(123)
indT <- createDataPartition(y=iris$Species, p=0.6, list=FALSE)
training <- iris[indT,]
testing <- iris[-indT,]

#Create a Decision Tree ML model

ModFit_rpart <- train(Species~., data=training, method="rpart",
                      parms = list(split="gini"))
#gini can be replaced by chisquare, entropy, information
#install.packages("rattle")
library(rattle)
fancyRpartPlot(ModFit_rpart$finalModel)

predict_rpart <- predict(ModFit_rpart, testing)

testing$PredRight <- predict_rpart==testing$Species

library(ggplot2)
ggplot(testing, aes(x=Petal.Width, y=Petal.Lenght))+
  geom_point(aes(col=PredRight))
View(iris)
