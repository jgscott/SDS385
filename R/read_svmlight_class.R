# read svmlight format matrix for classification problem
# each row is in the following format
# label feature1:val1 feature2:val2 ... featureK:valK
# assumes one-indexing for the column indices
# This function returns a list with the labels as a vector
# and the features stored as a sparse Matrix (or a simple triplet matrix)
# It requires the Matrix and readr packages.
read_svmlight_class = function(myfile, format='sparseMatrix', num_cols = NULL) {
	require(Matrix)
	require(readr)
	
	raw_x = read_lines(myfile)
	x = strsplit(raw_x, ' ', fixed=TRUE)
	x = lapply(x, function(y) strsplit(y, ':', fixed=TRUE))
	l = lapply(x, function(y) as.numeric(unlist(y)))
	label = as.integer(lapply(l, function(x) x[1]))
	num_rows = length(label)
	features = lapply(l, function(x) tail(x,-1L))
	row_length = as.integer(lapply(features, function(x) length(x)/2))
	features = unlist(features)
	i = rep.int(seq_len(num_rows), row_length)
	j = features[seq.int(1, length(features), by = 2)] + 1
	v = features[seq.int(2, length(features), by = 2)]

	if(missing(num_cols)) {
    		num_cols = max(j)
    	}
	m = sparseMatrix(i=i, j=j, x=v, dims=c(num_rows, num_cols))

	list(labels=label, features=m)
}
