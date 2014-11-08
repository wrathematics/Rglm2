library(Rglm2)
library(rbenchmark)

m <- 2000
n <- 1999 # 2000 with a constant
reps <- 2

#set.seed(1234)
x <- matrix(rnorm(m*n), m, n)
y <- rnorm(m)


benchmark(
#  lm(y~x), 
  lm2(y~x, check.rank=FALSE), 
  replications=reps, 
  columns=c("test", "replications", "elapsed", "relative")
)


#---------------------- 2000x1999 ----------------------#

### Atlas 
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   3.221    1.000
#  1                      lm(y ~ x)            2  10.387    3.225

### OpenBLAS 1 core
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   1.965    1.000
#  1                      lm(y ~ x)            2   6.469    3.292

### OpenBLAS 2 cores
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   1.346     1.00
#  1                      lm(y ~ x)            2   6.514     4.84

### OpenBLAS 4 cores
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   1.350    1.000
#  1                      lm(y ~ x)            2   6.755    5.004



#---------------------- 15992x250 ----------------------#

### Atlas 
#                            test replications elapsed relative
#2 lm2(y ~ x, check.rank = FALSE)            2   1.540    1.000
#1                      lm(y ~ x)            2   2.278    1.479


### OpenBLAS 1 core
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   1.239    1.000
#  1                      lm(y ~ x)            2   1.667    1.345


### OpenBLAS 2 cores
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   1.048    1.000
#  1                      lm(y ~ x)            2   1.694    1.616


### OpenBLAS 4 cores
#                              test replications elapsed relative
#  2 lm2(y ~ x, check.rank = FALSE)            2   1.094    1.000
#  1                      lm(y ~ x)            2   1.599    1.462



