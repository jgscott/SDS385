library(microbenchmark)
library(Matrix)

# D = read.csv('../data/slice_localization_data.csv')

N = 2000
P = 500
X = matrix(rnorm(N*P), nrow=N)
beta = rnorm(P)
eps = rnorm(N)
y = X %*% beta + eps


# Inversion method

inversion_solver = function(y, X) {
	XtX = crossprod(X)
	Xty = crossprod(X, y)
	betahat = solve(XtX) %*% Xty
	return(betahat)
}


default_solver = function(y,X) {
	XtX = crossprod(X)
	Xty = crossprod(X, y)
	betahat = solve(XtX, Xty)
	return(betahat)
}

chol_solver = function(y,X) {
	XtX = crossprod(X)
	Xty = crossprod(X, y)
	R = chol(XtX)
	u = forwardsolve(t(R), Xty)
	betahat = backsolve(R, u)
	return(betahat)
}


microbenchmark(
	inversion_solver(y,X),
	qr_solver(y,X),
	chol_solver(y,X),
	times=5)



# sparse
N = 2000
P = 500
X = matrix(rnorm(N*P), nrow=N)
mask = matrix(rbinom(N*P,1,0.05), nrow=N)
X = mask*X
Xs = Matrix(X)

beta = rnorm(P)
eps = rnorm(N)
y = X %*% beta + eps

sparse_solver = function(y,X) {
	XtX = crossprod(X)
	Xty = crossprod(X, y)
	betahat = Matrix::solve(XtX, Xty)
	return(betahat)
}



microbenchmark(
	chol_solver(y,X),
	sparse_solver(y, Xs),
	times=5)
	