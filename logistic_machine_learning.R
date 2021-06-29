# Logistic Regression : binary output
#install.packages("kernlab")
library(kernlab)
data(spam) # spam , not spam is binary output
names(spam)
table(spam)

library(caret)
set.seed(123)
#Divide between test and training
indTrain <- createDataPartition(y=spam$type,p=0.6,list = FALSE)
training <- spam[indTrain,]
testing  <- spam[-indTrain,]

#general linear model
ModFit_glm <- train(type~.,data=training,method="glm")
summary(ModFit_glm$finalModel)

prediction_glm <- predict(ModFit_glm, testing)
head(prediction_glm)

#Let's plot ROC-AUC curves
install.packages("ROCR")
library(ROCR)
pred_prob <- predict(ModFit_glm, testing, type="prob")
head(pred_prob)

pred_prob <- predict(ModFit_glm,testing, type = "prob")
head(pred_prob)
data_roc <- data.frame(pred_prob = pred_prob[,'spam'],
                       actual_label = ifelse(testing$type == 'spam', 1, 0))

roc <- prediction(predictions = data_roc$pred_prob,
                  labels = data_roc$actual_label)

plot(performance(roc, "tpr", "fpr"))
abline(0, 1, lty = 2) # garis diagonal, yaitu performa ketika asal tebak
auc <- performance(roc, measure = "auc")
auc@y.values


