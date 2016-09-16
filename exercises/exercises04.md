## Exercises 4: Better online learning (putting it all together)

[In these exercises](exercises04/exercises04-SDS385.pdf), you will work towards a solid, fast implementation of stochastic gradient descent, using one of two reasonably sophisticated ways of choosing the step size, and with support for sparse matrices.

I suggest you build and debug your code on one of your smaller data sets from before.  But [here's the data set you'll be building up to at the end of the exercises.](http://archive.ics.uci.edu/ml/datasets/URL+Reputation).  The goal here is to build a model that can detect malicious URLs in web traffic.  This data set has about 2.4 million observations and 3.2 million features, which isn't exactly Google-scale, but is big enough to cause serious problems with batch algorithms.  These features correspond to various lexical properties of the URL string, along with properties of the host and its IP address.  The outcome is whether the URL is malicious (coded 1) or not (coded -1).

### Data input

The data are stored across multiple files in a format called [SVMlight](http://www.gabormelli.com/RKB/SVMlight_Learning_File_Format), which is a sparse matrix format that's pretty common in machine-learning applications.  I've provided you with an [R function](../R/read_svmlight_class.R) for reading in these files; it behaves a bit like read.csv or read.table.  Note: my implementation is in pure R, and provides a good overview of some of R's string manipulation capabilities.  It makes use of vectorized functions wherever possible, but a pure C++ implementation would no doubt be faster here.

I've also a give you a [second R script](../R/process_urldata.R) that does three things:  
1) processes all the .svm files   
2) combines the files to form a single features matrix X and response vector Y (coded 0/1, rather than -1/+1)  
3) spits out two binary files, `url_X.rds` and `url_Y.rds`.  

You'll need to modify this script so that it points to the directory where you have saved the data (and the `read_svmlight_class.R` file, on which the script depends).  You'll also need the `Matrix` and `readr` packages.

You can read about .rds files [here](https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRDS.html).  The reason for step 3 is that reading data off disk is really slow, especially if that data is stored in some [ASCII-coded, text-based](https://www.cs.umd.edu/class/sum2003/cmsc311/Notes/BitOp/asciiBin.html) format like .csv (or like SVMlight).  However, if you read the data once and then store it as a binary (serialized) file, it's much faster to read in the second time.  For example, on my laptop, `process_urldata.R` takes more than 10 minutes to finish running.  But once the binary files have been created, they take only 10 seconds to load into memory again.  (See the [Stack Overflow question](http://stackoverflow.com/questions/11981434/file-operation-in-binary-vs-text-mode-performance-concern) here, for example, for some discussion of this point.)

The ASCII-based formats are certainly more portable, so it's unlikely you'll ever want to delete them after processing.  But if you intend to read in a data set more than once, you can afford the duplicated storage, and data I/O is a limiting performance factor, then it often pays to store a binary copy of the data too.

If you're working in Python, there are [handy functions](http://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_svmlight_file.html) for reading in SVMlight files in scikit-learn.


### Links

I mention L2 regularization in the exercises.  If you're unfamiliar with this idea, try starting from Section 3.4 on page 61 of [The Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/printings/ESLII_print10.pdf), by Hastie et. al.  For a situation with more features than data points, this kind of thing is essential.  The L2 penalty will involve a scalar tuning parameter. You should think carefully about how to choose this.   For those with a Bayesian background, L2 regularization is equivalent to an iid Gaussian prior on the regression coefficients.  (For those without a Bayesian background: it's not essential to understand this point to work through the exercises, or understand L2 regularization for its own sake.)

I also mentioned [Rcpp](http://www.rcpp.org) in the exercises.  I have posted an [illustration/demo of Rcpp here](../R/kernelcpp.R), in the form of a [simple Gaussian kernel smoother](https://en.wikipedia.org/wiki/Kernel_smoother).

If you use R regularly, you should learn Rcpp, which provides a nearly seamless link between R and C++ code, and is a brilliant addition to the R package universe.  (The "old" way to stitch compiled code into R required either C or Fortran, and was super clunky.)  A lot of native R functions (including all matrix operations) are written in C or C++, and are fast as a result.  But if you find yourself writing any kind of explicit loop in R (or an implicit loop, using apply or its variations), then coding the equivalent operation using Rcpp will likely offer a big speed-up.  In the Gaussian kernel smoothing example I posted above, I get more than a factor of 100x speedup in the C++ versus R implementation.

Matrix operations in Rcpp are given a very R/Matlab-like syntax via either RcppArmadillo or RcppEigen, both described on the main Rcpp page above.

### Sparse matrices

Rcpp functions based on RcppEigen can read in R's sparse-matrix format (in the Matrix package) directly, without any difficult type conversions.  (Probably RcppArmadillo can as well.  But I have always used Eigen for sparse matrices and Armadillo for dense matrices.  I find Armadillo syntax a littler easier to read, but at one point RcppArmadillo didn't have support for sparse matrices.  This has probably changed over the last 5 years and I'm just behind.)

[This blog post](http://gallery.rcpp.org/articles/sparse-iterators/) has a great series of "hello, world" style functions that show you how to iterate efficiently over the rows/columns/entries of a sparse matrix.  This is a key aspect of implementing SGD efficiently, where the main operation to to repeatedly calculate an inner product of the form X[i] dot beta, where X[i] is the feature vector for observation i.

Note: be sensitive to the format of your sparse matrix here.  It is much more efficient to loop column by column over a column-oriented sparse matrix.  Similarly, it is much more efficient to loop row by row over a row-oriented sparse matrix.



