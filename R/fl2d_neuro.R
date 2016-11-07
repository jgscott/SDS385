library(Matrix)
source("fl2d_stack.R")

fmri_z = as.matrix(read.csv("../data/fmri_z.csv"))
zvec = as.numeric(fmri_z)

image(Matrix(zvec, nrow=128, byrow=TRUE))

# Run the 2D fused lasso using proximal stacking
out = fl2d_stack(fmri_z, lambda = 1)

image(out$x)


lambda_grid = 10^seq(-3, 1, length=25)
mse_grid = seq_along(lambda_grid)
for(i in seq_along(lambda_grid)) {
	lambda = lambda_grid[i]
	out = fl2d_stack(fmri_z, lambda)
	# compute in-sample error
	mse_grid[i] = mean( (out$xvec[zvec !=0] - zvec[zvec !=0])^2 )
}

plot(lambda_grid, mse_grid, log='x')
abline(v=0.3)
