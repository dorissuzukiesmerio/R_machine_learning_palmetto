library(boot)
# function to obtain regression weights
bs <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample
  fit <- lm(formula, d)
  return(coef(fit))
}
# bootstrapping with 1000 replications
system.time(results <- boot(data=mtcars, statistic=bs,
                            R=10000, formula=mpg~wt+disp))

system.time(results <- boot(data=mtcars, statistic=bs,
                            R=10000, formula=mpg~wt+disp,
                            parallel = "snow",ncpus=2))