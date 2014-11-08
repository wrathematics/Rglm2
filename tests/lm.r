library(Rglm2)

m <- 100
n <- 5

#set.seed(1234)
x <- matrix(rnorm(m*n), m, n)
y <- rnorm(m)


mdl1 <- lm(y~x)
mdl2 <- lm2(y~x)

mdl1
mdl2

### 'call' literally can't agree, so don't check
mdl1$call <- NULL
mdl2$call <- NULL

### Also, X=QR is factored differently, so ignore the mean relative difference error
all.equal(mdl1, mdl2)
