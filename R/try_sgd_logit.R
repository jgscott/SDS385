library(Matrix)
library(Rcpp)
sourceCpp('sgdlogit.cpp')

# Read in serialized objects
system.time(X <- readRDS('url_X.rds'))
system.time(y <- readRDS('url_y.rds'))

n = length(y)
p = ncol(X)

# column-oriented storage of each observation
tX = t(X)

init_beta = rep(0.0, p)
system.time(sgd1 <- sparsesgd_logit(tX[1:10, 1:1000], y[1:1000], rep(1,n), eta = .1, npass=1, beta0 = init_beta[1:10], lambda=.1))



system.time(sgd1 <- sparsesgd_logit(tX, y, rep(1,n), eta = 2, npass=1, beta0 = init_beta, lambda=1e-8, discount = 0.001))
names(sgd1)

rafalib::splot(1:p, sort(sgd1$beta))
rafalib::splot(1:length(sgd1$nll_tracker), sgd1$nll_tracker)

