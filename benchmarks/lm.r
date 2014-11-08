library(Rglm2)
library(rbenchmark)

m <- 2000
n <- 1999
reps <- 2

#set.seed(1234)
x <- matrix(rnorm(m*n), m, n)
y <- rnorm(m)


benchmark(
  lm(y~x), 
  lm2(y~x), 
  replications=reps, 
  columns=c("test", "replications", "elapsed", "relative")
)


