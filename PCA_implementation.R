#Dimension reduction

# Principal Component Analysis
# Helpful to large datasets, with lots of colinearity
# Divide into different principles componenets
# Sum to certain % that represent 

rm=(list=ls())
dev.off
data(mtcars)
View(mtcars)
datain <- mtcars[,c(1:7,10:11)]

cin <- cov(scale(datain))
ein <- eigen(cin)
newpca <- -scale(datain %*% ein$vectors)

# Let compute PCA using builtin function 

mtcars.pca <- prcomp(datain, center=T, scale=T)
head(mtcars.pca)
summary(mtcars.pca)

#Importance of components:
#                         PC1    PC2     PC3     PC4     PC5     PC6     PC7
#Standard deviation     2.3782 1.4429 0.71008 0.51481 0.42797 0.35184 0.32413
#Proportion of Variance 0.6284 0.2313 0.05602 0.02945 0.02035 0.01375 0.01167
#Cumulative Proportion  0.6284 0.8598 0.91581 0.94525 0.96560 0.97936 0.99103
#PC8     PC9
#Standard deviation     0.2419 0.14896
#Proportion of Variance 0.0065 0.00247
#Cumulative Proportion  0.9975 1.00000
# So : with 3 components, CPA will be 0.91 - good 
install.packages("devtools")
library(devtools)
install_github("vqv/ggbiplot")

library(ggbiplot)
ggbiplot(mtcars.pca)
ggbiplot(mtcars.pca, labels=rownames(mtcars), )
