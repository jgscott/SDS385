library(Matrix)
source('makeD2_sparse.R')

# Smooth underlying truth
grid_locs = expand.grid(seq(0,6*pi, length=128), seq(0,6*pi, length=128))
mu = sin(grid_locs[,1]) + sin(grid_locs[,2])
n = length(mu)
z = mu + rnorm(n , 0, 1)

image(Matrix(z, nrow=128, byrow=TRUE))

D = makeD2_sparse(128,128)
L = crossprod(D)

# Testing set size
n = length(z)
n_test = floor(0.2*n)

# Which z's to drop?
dropind = sample.int(n, size=n_test)
z_drop = z; z_drop[dropind] = 0

# Cast as sparse matrix for viewing
image(Matrix(z_drop, nrow=128, byrow=TRUE))

# Solve Laplacian smoothing problem with missing data
eye_c = rep(1, n); eye_c[dropind] = 0
Eye_c = Diagonal(n, eye_c)


lambda_grid = 10^seq(-3, 2, length=20)
mse_grid = seq_along(lambda_grid)
for(i in seq_along(lambda_grid)) {
	lambda = lambda_grid[i]
	
	# solve the system with missing data
	A = Eye_c + lambda*L
	b = z_drop
	xhat = drop(solve(A, b, sparse=TRUE))
	xhat[z == 0] = 0
	
	# compute cross-validation error
	mse_grid[i] = mean( (xhat[dropind] - z[dropind])^2 )
}

plot(lambda_grid, mse_grid, log='x')

# Solution for optimal lambda with full data
lambda = lambda_grid[which.min(mse_grid)]
A = Diagonal(n, 1) + lambda*L
b = z
xhat = drop(solve(A, b, sparse=TRUE))


image(Matrix(z, nrow=128, byrow=TRUE))
image(Matrix(z_drop, nrow=128, byrow=TRUE))
image(Matrix(xhat, nrow=128, byrow=TRUE))

# Compare fit
plot(xhat, mu); abline(0,1)
