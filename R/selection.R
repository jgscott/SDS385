library(foreach)

N = 1000
NMC = 1000
out = foreach(i = 1:NMC, .combine='c') %do% {
	mu = rnorm(N, 0, 2)
	y = rnorm(N, mu, 1)
	iN = which.max(y)
	y[iN] - mu[iN]
}
mean(out)
hist(out, main=expression(y[(N)] - mu[i(N)])); abline(v=0)


# Selection bias
NMC = 1000
out2 = foreach(i = 1:NMC, .combine='rbind') %do% {
	mu = rnorm(N, 0, 2)
	y = rnorm(N, mu, 1)
	iN = which.max(y)
	error_mle = y[iN] - mu[iN]
	error_bayes = y[iN]/(1 + (1/4)) - mu[iN]
	c(error_mle, error_bayes)
}

par(mfrow=c(1,2))
hist(out2[,1], main=expression(y[(N)] - mu[i(N)])); abline(v=0)
hist(out2[,2], main=expression(hat(mu)[(N)] - mu[i(N)])); abline(v=0)

colMeans(out2)

# With Bayes correction
NMC = 1000
out2 = foreach(i = 1:NMC, .combine='rbind') %do% {
	mu = rnorm(N, 0, 2)
	y = rnorm(N, mu, 1)
	iN = which.max(y)
	error_mle = y[iN] - mu[iN]
	error_bayes = y[iN]/(1 + (1/4)) - mu[iN]
	c(error_mle, error_bayes)
}

par(mfrow=c(1,2))
hist(out2[,1], main=expression(y[(N)] - mu[i(N)])); abline(v=0)
hist(out2[,2], main=expression(hat(mu)[(N)] - mu[i(N)])); abline(v=0)

colMeans(out2)


# coverage of credible intervals
NMC = 1000
coverage_counts = foreach(i = 1:NMC, .combine='rbind') %do% {
	mu = rnorm(N, 0, 2)
	y = rnorm(N, mu, 1)
	iN = which.max(y)
	
	# Does the classical confidence interval cover?
	classical_cover = (mu[iN] >= y[iN] - 1.96) & (mu[iN] <= y[iN] + 1.96)
	
	# does the Bayesian interval cover?
	muhat_bayes = y[iN]/(1 + (1/4))
	std_bayes = sqrt(1/{1 + 1/4})
	bayes_cover = (mu[iN] >= muhat_bayes - 1.96*std_bayes) & (mu[iN] <= muhat_bayes + 1.96*std_bayes)
	
	c(classical_cover, bayes_cover)
}

colSums(coverage_counts)/NMC

