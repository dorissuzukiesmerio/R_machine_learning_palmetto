rm(list=ls())

#intense,complex computing functions:

max.eig <- function(N, sigma){
  d <-matrix(rnorm(N**2, sd=sigma), nrow=N)
  E <- eigen(d)$values
  abs(E)[[1]]
}

str(foreach) # to check syntax

foreach(i=1:4) %do% max.eig(i,1)

k=1
foreach(i=1:4) %:% #% is 
  doreach(k=1:4, .combine='c') %do% {
    max.eig(k,1)
    k=k+1
  }


library(doParallel)
detectCores() # in your pc or nodes 
co <- 8
cl <-makeCluster(co)
registerDoParallel(cl)

system.time(foreach(i=1:200, .combine = 'c') %do% max.eig(i,1))
system.time(foreach(i=1:200, .combine = 'c') %dopar% max.eig(i,1))
# dopar is much faster ; using multiple cores

library(Parallel)
co <- detectCores()-1
cl <- makePSOCKcluster(co)
setDefaultCluster(cl)

#Load necessary packages on the cluster workers
clusterExport(NULL, c('max.eig'))
system.time(foreach(i=1:200, .combine='c') %do% max.eig(i,1))
system.time(parLapply(NULL, 1:200, function(z) max.eig(z,1)))
stopCluster(cl)