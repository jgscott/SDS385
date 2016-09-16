source("read_svmlight_class.R")

# Where are the files stored?
base_dir = "~/Downloads/url_svmlight/"
svm_files = dir(base_dir, pattern = "*.svm")

# Loop through the files and create a list of objects
X_list = list()
y_list = list()
for(i in seq_along(svm_files)) {
	myfile = svm_files[i]
	cat(paste0("Reading file ", i, ": ", myfile, "\n"))
	D = read_svmlight_class(paste0(base_dir, myfile), num_cols = 3231962)
	X_list[[i]] = D$features
	y_list[[i]] = D$labels
}

# Assemble one matrix of features/vector of responses (do.call very handy here, although not super efficient
X = do.call(rBind, X_list)  # rBind, not rbind, for sparse matrices
y = do.call(c, y_list)
y = 0 + {y==1}

# Save as serialized (binary) files for much faster read-in next time
saveRDS(X, file='url_X.rds')
saveRDS(y, file='url_y.rds')
