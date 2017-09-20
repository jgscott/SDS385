library(MASS)

NMC = 10000

# Poisson
X = rpois(NMC, 10)
hist(X)
mean(X)
var(X)

# Mixture of Poissons
sigma = 0.5
lambda = exp(rnorm(NMC, log(10) - (sigma^2)/2, sigma))
X = rpois(NMC, lambda)
hist(X, 100)
mean(X)
var(X)

# Mixture of gammas
r = 3.7
mu = 22.4

a = r
b = r/mu
lambda = rgamma(NMC, shape = a, rate = b)
X = rpois(NMC, lambda)

# check moments
mean(X); mu
var(X); mu + (mu^2)/r

# the Neg Bin PMF
dnb = function(x, r, mu) {
	K = exp(lgamma(r+x) - lfactorial(x) - lgamma(r))
	K * (mu/(mu+r))^x * (r/(r+mu))^r
}

# verify we have the PMF right
hist(X, 30, prob=TRUE)
curve(dnb(x, r, mu), add=TRUE, col='red')

