# A simple example of using Rcpp to speed up a for loop.
# Application: Gaussian kernel smoothing.
library(Rcpp)
library(microbenchmark)
library(inline)  # for cppFunction

cppFunction('
  NumericMatrix KernelWeightsC(NumericVector x, NumericVector y, double bandwidth) {
    int d1 = x.size();
    int d2 = y.size();
    NumericMatrix C(d1,d2);
    for(int i = 0; i < d1; i++) {
    	  for(int j=0; j<d2; j++) {
    		C(i,j) = exp(-0.5*(pow(x[i] - y[j], 2.0))/bandwidth);
    	  }
    }
    return C;
  }
')


KernelWeightsR = function(x,y, bandwidth) {
	d1 = length(x)
	d2 = length(y)
	C = matrix(0, nrow=d1, ncol=d2)
	for(i in 1:d1) {
		for(j in 1:d2) {
			C[i,j] = exp(-0.5*((x[i] - y[j])^2)/bandwidth)
		}
	}
	return(C)
}


# Generate some points
x = runif(100, 0, 10)
bw = 1

# Calculate the smoothing weights based on pairwise distances
smoothing_matrix = KernelWeightsC(x, x, bw)

# The smoothing weights decay like a Gaussian away from the target point
whichx = 22
plot(x, smoothing_matrix[whichx,])
abline(v=x[whichx], col='red')

# See how the matrix can be used to smooth noisy observations
y = x + rnorm(100, 0, 1)
plot(x, y)

# Smooth the data
yhat = smoothing_matrix %*% y / rowSums(smoothing_matrix)
points(x, yhat, pch=19, col='blue') # smoothed values
abline(0,1) # truth

# Compare the R and C implementation for calculating the matrix
microbenchmark(
  KernelWeightsR(x, x, bw),
  KernelWeightsC(x, x, bw)
)

