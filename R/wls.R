library(microbenchmark)
library(Matrix)

N = 5000
P = 500
X = matrix(rnorm(N*P), nrow=N)
beta = rnorm(P)
weights = rgamma(N, 2, 2)  # some random weights
eps = rnorm(N, 0, 5*sqrt(1/weights))  # heteroscedastic error with variance \propto 1/weight
y = X %*% beta + eps


iqr_solver = function(y, X, w) {
	rw = sqrt(w)
	wX = rw * X
	wy = rw * y
	myqr = qr(wX)
	qty = qr.qty(myqr, wy)
	betahat = backsolve(myqr$qr, qty)
	betahat
}

chol_solver = function(y,X, w) {
	rw = sqrt(w)
	wX = rw * X 
	wy = rw * y
	XtWX = crossprod(wX)
	XtWy = crossprod(wX, wy)
	R = chol(XtWX)
	u = forwardsolve(t(R), XtWy)
	betahat = backsolve(R, u)
	return(betahat)
}

betahat_iqr = iqr_solver(y,X, weights)
betahat_chol = chol_solver(y,X, weights)

plot(betahat_iqr, betahat_chol)
plot(beta, betahat_iqr)
plot(beta, betahat_chol)

microbenchmark(
	iqr_solver(y,X, weights),
	chol_solver(y,X, weights),
	times=5)



# Now sparse systems

sparse_default_solver = function(y,X, w) {
	rw = sqrt(w)
	wX = rw * X 
	wy = rw * y
	XtWX = crossprod(wX)
	XtWy = crossprod(wX, wy)
	betahat = Matrix::solve(XtWX, XtWy)
	return(betahat)
}


# sparse
N = 5000
P = 500
X = matrix(rnorm(N*P), nrow=N)
mask = matrix(rbinom(N*P,1,0.01), nrow=N)
X = mask*X

# a sparse representation of X
Xs = Matrix(X)
beta = rnorm(P)
weights = rgamma(N, 2, 2)  # some random weights
eps = rnorm(N, 0, 5*sqrt(1/weights))  # heteroscedastic error with variance \propto 1/weight
y = Xs %*% beta + eps
y = as.numeric(y)


# some timings: matrix-vector multiplication
z = rnorm(P)
microbenchmark(
	Xs %*% z, 
	X %*% z, 
	times=10)


betahat_iqr = iqr_solver(y, X, weights)
betahat_schol = chol_solver(y, Xs, weights)
betahat_chol = chol_solver(y, X, weights)

plot(betahat_chol, betahat_schol)

microbenchmark(
	iqr_solver(y, X, weights),
	chol_solver(y, X, weights),
	sparse_default_solver(y,Xs, weights),
	chol_solver(y, Xs, weights),
	times=5)
	
	
######
# Now for a linear system where the gains from sparsity are much more dramatic!
# Application: image denoising
######

gridsize = 50
n = gridsize^2
grid_locs = expand.grid(1:gridsize, 1:gridsize)

# true image: outer product of sine waves
mu = 3*sin(grid_locs[,1]/3) + 3*sin(grid_locs[,2]/3)
mumat = matrix(mu, nrow=gridsize)

# Simulate some noisy data
y = mu + rnorm(n, 0, 2)
ymat = matrix(y, nrow=gridsize)

layout(matrix(c(1,2), nrow=1))
image(mumat)
image(ymat)

# Don't worry about this part (some smoothing magic)
D = genlasso::getD2dSparse(gridsize, gridsize) # fastcounts on rows
L = crossprod(D)
Omega = 5*L + Diagonal(n, 1)

# The point is that Omega^(-1) acts like a smoothing matrix
x = solve(Omega, y)  # smoothed data (using the sparse matrix solver here)
xmat = matrix(x, nrow=gridsize)

# Compare
layout(matrix(c(1,2,3), nrow=1))
image(mumat, main="Signal")
image(ymat, main="Data")
image(xmat, main="Hastily denoised data")

# Compare with what happens when we use a dense matrix (don't do this with gridsize > 65 or so)
Omega_dense = as.matrix(Omega)
microbenchmark(
	solve(Omega, y),
	solve(Omega_dense, y),  # this is idiotic
	times=2)
	

# What's the difference? Structure

# View sparsity pattern in XtX: pretty random
XtX = crossprod(Xs)
image(XtX > 0)

# View sparsity pattern in Omega: band diagonal (admittedly an extreme case)
image(Omega > 0)

