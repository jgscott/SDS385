
soft_thresh = function(x, lambda) {
	sign(x)*pmax(abs(x)-lambda, 0)
}

soft_thresh_norm = function(x, lambda) {
	result = soft_thresh(x, lambda)
	l2norm = sqrt(sum(result*result));
	if(l2norm > 0) {
		result = result/l2norm
	}
	return(result)
}

lambda_search = function(argx, constraint, abs.tol=1e-6, iter.max=200) {
  # argx: vector in R^d
  # constraint is an L1 inequality constraint
  # function finds scalar lambda such that x* = t(x)/L2(t(x)) <= constraint
  # where t(x) = S(x, lambda) the element-wise soft-thresholding operator with parameter lambda
  # and L2(t) is the Euclidean (L2) norm of t

  # Check if constraint is >= 1
  if(constraint < 1) {
  	stop('L1 constraint must be >= 1.')
  }
  
  # First check whether we have the zero vector and if so, set lambda=0
  argx.l2 = sqrt(sum(argx^2))
  if(argx.l2 == 0) {
    return(0)
  }
  
  # Can we use lambda=0?
  projection = soft_thresh_norm(argx, 0)
  projection.l1norm = sum(abs(projection))
  if(projection.l1norm < constraint) {
    return(0)
  } else {
    # the L1-norm constraint is violated
    # Initialize a binary search for the lambda leading to a tight L1 constraint  
    lambda.left = 0.0
    lambda.right = max(abs(argx))  # this is an upper bound on the lambda that will give a tight constraint
    
    
  	# Termination criterion: when the l1 norm of the vector is within abs.tol of constraint
  	counter = 0
  	exceedance = max(1, 10*abs.tol)
  	while( abs(exceedance) > abs.tol && counter < iter.max) {
  		
		# Threshold and normalize the vector
		lambda.mean = (lambda.left + lambda.right)/2.0
		projection = soft_thresh_norm(argx, lambda.mean)
		projection.l1norm = sum(abs(projection))
		exceedance = projection.l1norm - constraint

		if(exceedance < 0) {
			# The constraint is slack, and therefore lambda.mean is too large
     	   lambda.right = lambda.mean
		} else {
			# The constraint is violated, and therefore lambda.mean is too small
			lambda.left = lambda.mean
		}
		counter = counter+1

  	}
  }
  return(lambda.mean)
}


find_one_factor = function(X, left.constraint, right.constraint, v.init=NULL, rel.tol = 1e-4, abs.tol=1e-4) {
# X is an n.left by n.right data matrix
# This function finds sparse vectors (u=left.factor, v=right.factors)
# to maximize the target u' X v subject to the L1 and L2 constraints
# |u|_2 = 1, |u|_1 <= left.constraint
# |v|_2 = 1, |v|_1 <= right.constraint

  n.right = ncol(X)
  if( missing(v.init) ) {
  	right.factor = rep(1/sqrt(n.right), n.right) # initialize right.factor to have unit L2 norm
  }
  else {
  	right.factor = v.init/sqrt(sum(v.init^2))
  }

  d.old = 0
  mytest = max(1, 2*rel.tol)
  while( mytest > rel.tol ) {
  	
  	# update u, given v
    left.arg = drop(X %*% right.factor)
    left.lambda = lambda_search(left.arg, left.constraint, abs.tol=abs.tol)
    left.factor = soft_thresh_norm(left.arg, left.lambda)
	
	# update v, given u
	right.arg = crossprod(X, left.factor)
    right.lambda = lambda_search(right.arg, right.constraint, abs.tol=abs.tol)
    right.factor = soft_thresh_norm(right.arg, right.lambda)
    
    # check convergence
    d.new = drop( matrix(left.factor, nrow=1) %*% X %*% matrix(right.factor, ncol=1) )
    mytest = abs(d.new - d.old)/(d.old + rel.tol)
    d.old = d.new
  }
  
  fitted = d.new*tcrossprod(left.factor, right.factor)
  residual = X - fitted
  list(u = left.factor, v = right.factor, d = d.new, fitted=fitted, residual=residual)
}




