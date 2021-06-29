#Ozone airquality : continuous

set.seed(123)
ind2 <- createDataPartition(y=DataImputeBag$Ozone,p=0.6,list=F)
training1 <- DataImputeBag[ind2,]
testing1  <- DataImputeBag[-ind2,]

fitControl1 <- trainControl(method="cv",number=10)
model1 <- train(Ozone~Solar.R+Wind+Temp,data=training1,
                trControl = fitControl1,method="lm")
print(model1)
predict1 <- predict(model1,testing1)
print(predict1)

cor(predict1,testing1$Ozone)^2
cor.test(predict1,testing1$Ozone)

postResample(predict1,testing1$Ozone)

