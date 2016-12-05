library(OpenImageR)

markov = readImage('../data/markov.jpg')
imageShow(markov)

# Convert to greyscale
markov_gray = rgb_2gray(markov)
imageShow(markov_gray)

# Downsample to be smaller
markov_gray  = resizeImage(markov_gray, height = 256, width = 192, method = 'bilinear')

# standardize
mu = mean(markov_gray)
sigma = sd(markov_gray)
markov_z = (markov_gray - mu)/sigma
imageShow(markov_z)

# Build a vertical edge-detection filter
filter_size = 8
beta_vert = matrix(-3, nrow=8, ncol=8)
beta_vert[,5:8] = 3
beta_vert

# convolve filter with image: "stride" of 3
stride = 3
nx = 192
ny = 256

# Some annoying math to calculate the size of the final convolution
out = matrix(0, nrow=floor((nx-filter_size+1)/stride), ncol=floor((ny-filter_size+1)/stride))
for(i in seq(1, nx-filter_size, by=stride)) {
	for(j in seq(1, ny-filter_size, by=stride)) {
		out[i/stride,j/stride] = sum( beta_vert * markov_z[i:(i+ filter_size-1), j:(j+ filter_size-1)] )
	}
}

imageShow(out)

# How about a horizontal edge?
beta_hori = matrix(-3, nrow=8, ncol=8)
beta_hori[5:8,] = 3
beta_hori

out2 = matrix(0, nrow=floor((nx-filter_size+1)/stride), ncol=floor((ny-filter_size+1)/stride))
for(i in seq(1, nx-filter_size, by=stride)) {
	for(j in seq(1, ny-filter_size, by=stride)) {
		out2[i/stride,j/stride] = sum( beta_hori * markov_z[i:(i+ filter_size-1), j:(j+ filter_size-1)] )
	}
}

imageShow(out)
imageShow(out2)

# How about a diagonal edge?
filter_size = 8
beta_diag = matrix(-3, nrow= filter_size, ncol= filter_size)
for(i in 1: filter_size) { for(j in 1: filter_size) {
	if( i <= j ) beta_diag[i,j] = 3
}}
beta_diag
beta_diag = beta_diag - mean(beta_diag)
image(beta_diag)

out3 = matrix(0, nrow=floor((nx-filter_size+1)/stride), ncol=floor((ny-filter_size+1)/stride))
for(i in seq(1, nx-filter_size, by=stride)) {
	for(j in seq(1, ny-filter_size, by=stride)) {
		out3[i/stride,j/stride] = sum( beta_diag * markov_z[i:(i+ filter_size-1), j:(j+ filter_size-1)] )
	}
}
imageShow(out3)
