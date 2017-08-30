# SDS385

Welcome to SDS 385, a Ph.D.-level course on statistical models for big data.  All course materials can be found through this GitHub page.  

Some course logistics   
- Instructor: James Scott, <http://jgscott.github.com>  
- Meets: Mondays and Wednesday, 9:30 - 11:00 AM
- Classroom: PHR 2.116
- Unique number: 57075  



## Exercises 

[You can find all the exercises here.](exercises/)  I'll post them as they become relevant throughout the semester.

## Peer evaluation  

For the purpose of peer evaluation, you can find links [to people's GitHub pages here](team/).  


## About the course

This is a [Moore-method](https://en.wikipedia.org/wiki/Moore_method) course.  There are very few regular lectures.  Mostly, you will work on the [exercises outside of class](exercises/).  When you come to class, you will share what you've done, and benefit from understanding what others have done.  There's nothing else to it.  We will end up covering less than in a traditional lecture-based course.  But what you learn, you will learn very deeply.  The trade-off is more than worth it.   

While the course is much more about methods and applications than about theory, we will need a fair bit of (not-too-hard) math.  To that end, I assume that you know the following topics well.  These three are super important; if you don't have them, you should not be in this course.  
- linear algebra  
- multivariable calculus (really, you just need to understand gradients and Hessians)  
- how to program in a scripting language like R, Python, Matlab, etc.  

The following three are still assumed pre-requisites, but they're things you can probably pick up along the way if you are weak on one and willing to work hard:
- probability (although measure theory isn't necessary)  
- basic inferential statistics   
- regression (including some exposure to generalized linear models)  

If you have any doubt about your preparation for this course, feel free to chat with me on the first day.  

Three notes here:  

1.  This course is focused on the statistical and algorithmic principles needed to confront large data sets.  It is not, at least primarily, about the practical issues associated with gathering, storing, cleaning, curating, and managing large data sets.  These things are super important, and we'll certainly encounter some of them.  But they're highly field dependent: if you're a linguist or a finance person, you'll be working with entirely different software and database systems than if you're a neuroscientist or an infectious-disease researcher.  And unfortunately, I can't teach them all.  

2. A corollary of (1) is that, if you're coming to this course hoping to learn a particular software stack that will send you out into industry as a big-data guru, you will almost certainly end up disappointed.  However, if you come here hoping to understand the deeper principles behind any serious attempt at analyzing big data, then this is the course for you.  You will have to do some work on your own to marry these principles with the practical software skills appropriate for your chosen field.  But I can promise you that your efforts will be rewarded, and that you'll be set up for far more lasting success than the guy whose expertise consists of a week on Coursera learning how to use Spark to run some black-box machine-learning algorithm on a terabyte of data.  I've met that guy.  Don't be that guy.  

3. This is an unusual graduate-level course, in that it's designed to serve two distinct populations: students in statistics/CS, whose research usually involves developing new methods; and students in the biological and physical sciences, whose research usually involves answering empirical questions.  These students bring different skill sets and knowledge bases to the course, and they have different goals.  The grading and expectations have to deal with this.  See below.  


## Reference materials  

Nothing to buy here.  Here are some references:  

- [The Elements of Statistical Learning](https://web.stanford.edu/~hastie/ElemStatLearn/), by Hastie, Tibshirani, and Friedman.  A great reference, and free online.  
 - [Advanced R](http://adv-r.had.co.nz/), by Hadley Wickham.  No need to buy the book; just a useful online reference.  
  - [Advanced R](http://adv-r.had.co.nz/), by Hadley Wickham.  No need to buy the book; just a useful online reference.  
 - _Numerical optimization_, by Jorge Nocedal and Stephen J. Wright.  This should be available in electronic form through from the UT Library website.  
- [Statistical modeling: a gentle introduction](misc/stat_models.pdf).  A basic undergraduate-level textbook on regression modeling.  Chapters 2-4, 6 and 8 form the bare-minimum background on regression that you need to be successful in this course.  There's no linear algebra here.  

## Grading

Your grade consists of three equally weighted piece: 1/3 in-class contributions, 1/3 peer evaluation, and 1/3 final project.

### In-class contributions

During the semester, you will be expected to do two main things on a recurring basis:  
1) Work on the problems and coding assignments outside of class, and document your code so that someone else can follow it.  You will post all of your code and materials on your GitHub page.  
2) Present your work in front of class, either up at the board or by hooking up your computer and showing us your code and results.  

You will also be asked to make an in-class presentation on a scientific data-analysis problem.  These could be about something in your own research, or from a classic data set or journal article in your field.  The goal is to teach your new friends about a problem where big-data tools are necessary to make progress. 
 
These presentations come in two varieties: short and long.  
- Short presentations are 5-10 minutes long.  If you're a stats or CS student -- or behaving like one -- and therefore presenting a bit more in class on the methods and code, you can do a short presentation.  Short presentations need only describe the problem; no code required.  
- Long presentations are 25 minutes long and go into more detail.  If you're doing less of the heavy lifting day to day on the derivations, you're expected to do a long presentation.  Long presentations must be accompanied by example code that you describe in class and put up on your GitHub page.  

I expect people to sort themselves into the appropriate category here.  I'll post more information on these presentations, as well as a schedule, once the class enrollment situation settles down.  


### Peer evaluation

You will provide three "peer reviews" of others' code and analyses from their GitHub pages, so that everyone gets feedback.  You'll do this about once every 3-4 weeks, and I'll assign the reviewers randomly.  

In addition, at the end of the semester, everyone will (privately) turn in a document that summarizes their assessment of each person's contribution to the course.  Those who have helped others to learn by offering thoughtful peer reviews (or by presenting excellent work in class) will presumably get good evaluations.  I'll use these summaries to set the peer-evaluation grades.  (Note: I'll still have the final say here.)  


### Final project  

Pick some relevant topic that interests you.  Clear it with me ahead of time, and then do it!  Basically, I trust you to choose something that will optimize your own learning experience, and that will dovetail with your research and educational goals.  It certainly can overlap with your dissertation.  Examples:  
1) Analyze a data set from your own research, using techniques from class or closely related techniques.  
2) Invent a new technique and show how awesome it is.  
3) Prove something interesting about a procedure or algorithm related to what we're studying (admittedly unlikely, but certainly possible!)  
4) Read a paper, or a group of related papers, that expands on some topic we've covered in class.  Implement the method and benchmark it against something else.  

Final projects are due on the last class day of the semester: Monday, December 11.  

You should feel free to work in teams of three or smaller, although you don't have to.  For example, a fantastic outcome would be if a CS/Stats student teamed up with a Bio/Neuro student to help solve some actual scientific problem using a technique related to what we're covering.  


## Requirements  

1) Set up a [GitHub](www.github.com) account if you don't already have one.  

2) Learn how to use GitHub, either via the command line or through a source-code browser like GitHub Desktop or SourceTree.   

3) Optional, but recommended: bring your own data!  


## Topics

Here's a partial list of topics that we'll cover.   

- Big regression models  
- Regularization and sparsity in statistical models  
- Enough convex optimization to be dangerous  
- Online learning  
- Multiplicity (multiple comparisons, multiple testing) in big-data analysis   
- Matrix factorization and its applications (e.g. recommender systems, modeling covariance matrices)    
- Latent-variable models at scale  
- Big spatial models  

If time:
- Modeling non-numerical (e.g. binary/ordinal/text) data  
- Resampling-based methods at scale  


## Miscellaneous links  

### Graph-fused lasso    

Here are a few items related to applications and generalizations of the graph-fused lasso.

- [Slides from class on 11/9/2016](misc/class_version.pdf)  
- [Linear-time solution of the 1D fused lasso](http://www.tandfonline.com/doi/abs/10.1080/10618600.2012.681238)    
- [glmgen](https://github.com/statsmaths/glmgen) R package for fast fused lasso and trend-filtering code  
- [Paper on trend filtering](https://arxiv.org/abs/1304.2986)  
- [Fast ADMM for trend filtering](https://arxiv.org/abs/1406.2082)  
- [Trend filtering on general graphs](https://arxiv.org/abs/1410.7690)  
- [Multiscale spatial density smoothing](https://arxiv.org/abs/1507.07271)  
- [False discovery rate smoothing](https://arxiv.org/abs/1411.6144)  
