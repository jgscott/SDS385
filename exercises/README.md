

# Exercises

## Preliminaries

The goal of this warm-up assignment is to provide you with an introduction to optimization and its role in data analysis.  

For this section, please read Chapter 2 of _Numerical Optimization_, by Nocedal and Wright.  The full text of this book is available for free through the [UT Library website](http://lib.utexas.edu).  You should come away with a good general understanding of two methods for optimizing smooth functions:  
1) the method of steepest descent, or simply _gradient descent_, and   
2) Newton's method.  

Feel free to skip the stuff about trust-region methods.  The overview of quasi-Newton methods is nice, but optional for now.  

The [exercises for this unit](exercises01/exercises01-SDS385.pdf) will have you practice these techniques.  They will also will hammer your linear algebra skills.  


## Online learning

[The goal in this exercise](exercises02/exercises02-SDS385.pdf) to get some working code -- not necessarily fast or efficient code -- that fits a logistic-regression model by stochastic gradient descent (SGD).  The idea of SGD is to fit the model in such a way that we process only one observation at a time (or possibly a small handful of observations, called minibatches). This contrasts sharply with ordinary gradient descent or Newton's method, both of which require that we process the entire data set in order to take a simple step.  In future applications -- not quite yet -- SGD will even allow us to fit a model in such a way that we never have to load a full data set into your computer's working memory.  Instead we can just read it a chunk at a time off the hard drive.  This is very handy if you have more data than memory!

But as we'll see, getting stochastic-gradient descent right is tricky.  We'll learn the basics now, recognize the key issues, and save the more advanced stuff (for addressing those issues) for the next set of exercises.  



