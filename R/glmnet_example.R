library(glmnet)
library(SIS)
library(foreach)

data(prostate.train)
data(prostate.test)

# 102 observations, 12600 features + 1 response
# last column = response
dim(prostate.train)

y_train = prostate.train[,12601]
X_train = as.matrix(prostate.train[,-12601])

y_test = prostate.test[,12601]
X_test = as.matrix(prostate.test[,-12601])

# fit model with ridge (l2) penalty
# Logistic regression model (generalized linear model)
# See ch 16 of basic notes from GitHub page
glm1 = glmnet(X_train, y_train, family='binomial',
	lambda = 10^seq(1, 4, length=50),
	alpha=0)

str(glm1$beta)


yhat_train = predict(glm1, newx=X_train, type='response')
dim(yhat_train)

err_train = foreach(i = 1:ncol(yhat_train), .combine='c') %do% {
	sqrt(mean((y_train - yhat_train[,i])^2))
}

plot(glm1$lambda, err_train, log='x', ylim=c(0,1))


yhat_test = predict(glm1, newx=X_test, type='response')
dim(yhat_test)

err_test = foreach(i = 1:ncol(yhat_test), .combine='c') %do% {
	sqrt(mean((y_test - yhat_test[,i])^2))
}

# training versus test error
plot(glm1$lambda, err_train, log='x', ylim=c(0,1), type='l')
lines(glm1$lambda, err_test, col='red')

# pick out "best" beta
ind_best = which.min(err_test)
lambda_best = glm1$lambda[ind_best]
alpha_best = glm1$a0[ind_best]
beta_best = glm1$beta[,ind_best]

# the betas themselves
head(beta_best, 50)
plot(sort(beta_best))
