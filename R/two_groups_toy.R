N = 10000

# Parameters
tau2 = 2^2  # variance of signals
sigma2 = 1  # variance of noise
w = 0.15 # proportion of signals

# simulate some sparse signals
mu = rnorm(10000, 0, sqrt(tau2))
mask = rbinom(N, 1, w)
mu = mask*mu

plot(mu)

# data (test statistics)
z = rnorm(N, mu, sqrt(sigma2))
hist(z, 100)

####
# Naive case-by-case test at alpha = 0.05
####

discovery = (abs(z) > 1.96*sqrt(sigma2))
confusion_matrix = xtabs(~mask + discovery)
confusion_matrix

# false discovery rate
confusion_matrix[1,2]/sum(discovery)


####
# Now fit the two-groups model by maximum likelihood
####

# Define a target function whose first variable is to be optimized over
target = function(theta, z, sigma2) {
	w = 1/{1+exp(-theta[1])}  # transform to deal with [0,1] restriction
	tau2 = exp(theta[2])  # transform to deal with (0, inf) restriction
	likelihood = w*dnorm(z, 0, sqrt(sigma2 + tau2)) + (1-w)*dnorm(z, 0, sigma2)
	-sum(log(likelihood))
}

# Optimize with initial guess = (0,0)
my_opt = optim(c(0,0), target, method='Nelder-Mead', z=z, sigma2=sigma2)

theta_hat = my_opt$par
w_hat = 1/{1+exp(-theta_hat[1])}
tau2_hat = exp(theta_hat[2])

# Now calculate the posterior probability of being a signal
f_mix = w_hat*dnorm(z, 0, sqrt(sigma2 + tau2_hat)) + (1-w_hat)*dnorm(z, 0, sigma2)
f1 = w_hat*dnorm(z, 0, sqrt(sigma2 + tau2_hat))
post_prob = f1/f_mix

discovery_bayes = (post_prob > 0.5)
confusion_bayes = xtabs(~mask + discovery_bayes)
confusion_bayes

# False discovery rate
confusion_bayes[1,2]/sum(discovery_bayes)

