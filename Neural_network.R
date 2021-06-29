# Neural Network

#Neural Net
install.packages("neuralnet")
library(neuralnet)

library(caret)
library(neuralnet)

datain <- mtcars
set.seed(123)
#Split training/testing
indT <- createDataPartition(y=datain$mpg,p=0.6,list=FALSE)
training <- datain[indT,]
testing  <- datain[-indT,]
#scale the data set
smax <- apply(training,2,max)
smin <- apply(training,2,min)
trainNN <- as.data.frame(scale(training,center=smin,scale=smax-smin))
testNN <- as.data.frame(scale(testing,center=smin,scale=smax-smin))

dev.off()
set.seed(123)
ModNN <- neuralnet(mpg~cyl+disp+hp+drat+wt+qsec+carb,trainNN, hidden=10,linear.output = T)
plot(ModNN)

#Predict using Neural Network
predictNN <- compute(ModNN,testNN[,c(2:7,11)])
predictmpg<- predictNN$net.result*(smax-smin)[1]+smin[1]
postResample(testing$mpg,predictmpg)