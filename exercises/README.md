

# Exercises

## Exercises 1: Preliminaries

The goal of this warm-up assignment is to provide you with an introduction to optimization and its role in data analysis.  

For this section, please read Chapter 2 of _Numerical Optimization_, by Nocedal and Wright.  The full text of this book is available for free through the [UT Library website](http://lib.utexas.edu).  You should come away with a good general understanding of two methods for optimizing smooth functions:  
1) the method of steepest descent, or simply _gradient descent_, and   
2) Newton's method.  

Feel free to skip the stuff about trust-region methods.  The overview of quasi-Newton methods is nice, but optional for now.  

The [exercises for this unit](exercises01/exercises01-SDS385.pdf) will have you practice these techniques.  They will also will hammer your linear algebra skills.  


## Exercises 2: Online learning

[The goal in this exercise](exercises02/exercises02-SDS385.pdf) to get some working code -- not necessarily fast or efficient code -- that fits a logistic-regression model by stochastic gradient descent (SGD).  The idea of SGD is to fit the model in such a way that we process only one observation at a time (or possibly a small handful of observations, called minibatches). This contrasts sharply with ordinary gradient descent or Newton's method, both of which are _batch methods_: they require that we process the entire data set as a batch in order to take a single step.  In future applications -- not quite yet -- SGD will even allow us to fit a model in such a way that we never have to load a full data set into your computer's working memory.  Instead we can just read it a chunk at a time off the hard drive.  This is very handy if you have more data than memory!

But as we'll see, getting stochastic-gradient descent right is tricky.  We'll learn the basics now, recognize the key issues, and save the more advanced stuff (for addressing those issues) for the next two sets of exercises.  


<!-- ## Exercises 3: Better online learning (preliminaries_

[The goal in this exercise](exercises03/exercises03-SDS385.pdf) is to set the stage for some big improvements to stochastic gradient descent.  To do so, we'll need to revisit our two batch optimizers from before: ordinary gradient descent, and Newton's method.  These exercises will have you implement backtracking line search and the BFGS method for logistic regression.  Both of these ideas will carry forward, with some modifications, to the online-learning setting.  


## Exercises 4: Better online learning (putting it all together)

[I put this description on a separate page](exercises04.md) due to length.  You should aim to have these completed by Wednesday, September 28th.  On Monday, September 26th, we'll have a "lab day" in class, where people can work on the problem, exchange ideas, and share code.  




## Exercises 5: Sparsity

[Link here.](exercises05/exercises05-SDS385.pdf)

In many problems, we wish to impose _sparsity_ on the parameters of a statistical model -- that is, the assumption that some parameters are zero.    In this set of exercises, we will learn a few basic ideas that are important for thinking about sparse statistical models at scale.

Please finish reading Chapter 3.4 of [The Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/), although feel free to skip the part about "Least angle regression."  The key things to take away from this reading are:  
- the lasso  
- the idea of the lasso solution path (Figure 3.10)  
- the degrees of freedom for the lasso (page 77)

Note that we will work the lasso objective in "Lagrangian form" (Equation 3.52).  If you want a short overview of how the software you'll be using on this set of exercises actually fits the lasso, see Chapter 3.8.6 (Pathwise Coordinate Optimization), or the paper below for more detail.  But as you'll see, it's super fast.

### Extended reading

The following papers treat some of the issues that arise in lasso regression in much greater detail.  They are optional, but provide nice background.

- [The original paper on the lasso](http://statweb.stanford.edu/~tibs/lasso/lasso.pdf) 
- [Paper on pathwise coordinate optimization](http://arxiv.org/pdf/0708.1485.pdf)  
- ["Degrees of freedom" of the lasso fit](https://projecteuclid.org/euclid.aos/1194461726)  
- [Estimating the residual variance from the lasso fit](https://arxiv.org/abs/1311.5274).  Note that in the exercises we use their Equation 2 in our definition of CP.  
- [Estimating prediction error](https://people.eecs.berkeley.edu/~jordan/sail/readings/archive/efron_Cp.pdf).  


## Exercises 6: the proximal gradient method

[Link here.](exercises06/exercises06-SDS385.pdf)

The culmination of the first four exercises was _stochastic gradient descent_, which is one of the core algorithms that powers modern data science.  Over the next few sets of exercises, we will build up to two other such core algorithms: the proximal gradient method, and ADMM, which stands for the _alternating direction method of multipliers._  These algorithms are broadly useful for optimizing objective functions f(x) in statistics that have either or both of the following two features:  
- f(x) is a sum of two terms, one of which measures fit to the data, and the other of which penalizes model complexity.  
- f(x) is not everywhere smooth, so that we cannot assume derivatives exist.  

Both features come up in problems where we wish to impose sparsity on a parameter in a statistical model (i.e. the lasso of the previous exercises).  

In this set of exercises, we begin our study of scalable algorithms that can handle sparsity, with the proximal gradient method.


### Optional reading

These exercises are fairly self contained.  Nonetheless, if you want a very detailed reference on the proximal gradient algorithm, and many related algorithms, I highly recommend [this review paper](http://web.stanford.edu/~boyd/papers/prox_algs.html) by Parikh and Boyd.


## Exercises 7: Introduction to ADMM

### Reading

In this set of exercises, there is a lot of reading.  The main reference is a review paper called [Distributed Optimization and Statistical Learning via the Alternating Direction Method of Multipliers](http://stanford.edu/~boyd/papers/admm_distr_stats.html), by Boyd et al.  This is a truly excellent review paper -- and a popular one, as its citation count on Google Scholar reveals.  For this set of exercises I ask that you read Sections 1-6 of this paper.

You may or may not be familiar with some of the basic concepts in convex optimization used in the paper.  If you're not, you can find some very useful background material on Lagrangians and duality in Chapter 5 (and for background, 3.3) of [Convex Optimization](http://stanford.edu/~boyd/cvxbook/), by Boyd and Vandeberghe (see the Download link at the bottom of this linked page).  

### Exercises

The assignment this week is simple: implement ADMM for fitting the lasso regression model, and compare it to your proximal gradient implementation from last week.  The application of ADMM to the lasso model is described in Section 6.4 of the Boyd et. al. paper.  I encourage you to try to derive these steps yourself from the generic ADMM recipe, and then check against Section 6.4.  

In the exercises to follow, we'll use ADMM again for several other problems, including spatial smoothing.  


## Exercises 8: spatial smoothing at scale  

[Link here.](exercises08/exercises08-SDS385.pdf)  In this set of exercises, you will extend your knowledge of ADMM by considering the problem of spatial smoothing over large discrete lattices.  The application we consider this week is to data collected from an fMRI experiment.

Files:  
- [Data](../data/fmri_z.csv) 
- [a utility R script](../R/makeD2_sparse.R) for constructing the first-difference matrix over a grid graph  


## Exercises 9: matrix factorization

[Link here.](exercises09/exercises09-SDS385.pdf)  

In statistical modeling, we often need to compute a low-rank approximation to a large matrix.  The standard old-school approach for doing so is _principal components analysis,_ or PCA, which is closely related to the [singular value decomposition](https://en.wikipedia.org/wiki/Singular_value_decomposition) of a matrix.  

In this set of exercises, you will explore an approach for computing a modified PCA-like factorization of a matrix.  Specifically, you will incorporate regularization on the principal components, in the form of a penalty function.  This leads to a [biconvex](https://en.wikipedia.org/wiki/Biconvex_optimization) optimization problem that can be solved quite rapidly.   

Readings for this week:
- A review of principal components analysis in [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/), Section 10.2.  
- The paper ["A penalized matrix decomposition, with applications to sparse principal components and canonical correlation analysis"](https://faculty.washington.edu/dwitten/Papers/pmd.pdf), by Witten, Tibshirani, and Hastie.   
- Optional: [more background](https://www.cs.cmu.edu/~venkatg/teaching/CStheory-infoage/book-chapter-4.pdf) on the singular value decomposition.  

 -->



