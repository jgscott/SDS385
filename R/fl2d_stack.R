library(Rcpp)
library(Matrix)
sourceCpp('fl_dp.cpp')

fl2d_stack = function(y, lambda = 1, iter_max = 500, rel_tol = 1e-3, inflate=1.5) {
	# y: matrix of data
	# lambda: penalty
	# inflate: governs how rapidly we rescale the dual variables to ensure primal/dual residuals of same magnitude
	n = nrow(y)
	m = ncol(y)
	
	# Do some naive smoothing to get the initial guess
	x = 0.75*y + 0.25*mean(y)
	z = matrix(0, nrow=n, ncol=n) # slack variable for likelihood
	u = matrix(0, nrow=n, ncol=n) # scaled dual variable for constraint
	a = 2*lambda

	primal_trace = NULL
	dual_trace = NULL
	converged = FALSE
	counter = 0
	while(!converged & counter < iter_max) {
	
		# Update rows (original primal variable)
		this_y = (y + a*(z - u)) / (1+a)
		for(i in 1:n) {
			x[i,] = fl_dp(this_y[i,], lambda)
		}
		
		# Update columns (slack variable z = x)
		z_new = z
		for(i in 1:m) {
			z_new[,i] = fl_dp(x[,i] + u[,i], lambda)
		}
		dual_residual = a*(z_new - z)
		z = z_new
		
		# Update scaled dual variable
		primal_residual = x - z
		u = u + primal_residual
		
		# check convergence
		primal_resnorm = sqrt(mean(primal_residual^2))
		dual_resnorm = sqrt(mean(dual_residual^2))
		primal_check = primal_resnorm / (rel_tol + max(sqrt(mean(x^2)), sqrt(mean(z^2))))
		dual_check = dual_resnorm / (rel_tol + sqrt(mean(u^2)))
		
		if(dual_resnorm < rel_tol && primal_resnorm < rel_tol) {
			converged=TRUE
		}
		
 		# Update step-size parameter based on norm of primal and dual residuals
		if(primal_resnorm > 5*dual_resnorm) {
			a = inflate*a
			u = u/inflate
		} else if(dual_resnorm > 5*primal_resnorm) {
			a = a/inflate
			u = inflate*u
		}
		primal_trace = c(primal_trace, primal_resnorm)
		dual_trace = c(dual_trace, dual_resnorm)
		counter = counter+1
	}
	x[y==0] = 0
	xvec = as.numeric(x)
	x = Matrix(xvec, nrow=nrow(y), byrow=TRUE)
	list(x=x, xvec= xvec, z=z, u=u, primal_trace = primal_trace, dual_trace= dual_trace, counter=counter);
}
