soft = function(x, r) {
	sign(x)*pmax(abs(x) - r, 0)
}



y = 2.7
lambda = 1
sig2 = 1.6

curve((1/(2*sig2))*(y-x)^2 + lambda*abs(x), from=-4, to=4, ylim=c(0, 10))

abline((1/(2*sig2))*y^2, -lambda - y/sig2, col='red')
abline((1/(2*sig2))*y^2, lambda - y/sig2, col='red')
abline(v=soft(y, lambda*sig2), col='blue')
