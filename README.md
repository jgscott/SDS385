# SDS385

Welcome to SDS 385, a Ph.D.-level course on statistical models for big data.  All course materials can be found through this GitHub page.  

Some course logistics   
- Instructor: James Scott, <http://jgscott.github.com>  
- Meets: Mondays and Wednesday, 9:30 - 11:00 AM
- Classroom: Parlin 103
- Unique number: 56960

## About the course

This is a [Moore-method](https://en.wikipedia.org/wiki/Moore_method) course.  There are no regular lectures.  You will work on the assignments outside of class.  When you come to class, you will share what you've done, and benefit from understanding what others have done.  There's nothing else to it.  It's a brilliant way to learn!

While the course is much more about methods and applications than about theory, we will need a fair bit of (not-too-hard) math.  To that end, I assume that you know the following topics well:  
- linear algebra  
- multivariable calculus  
- how to program in a language like R or Python  
- probability (although measure theory isn't necessary)  
- basic inferential statistics  
- regression (including some exposure to generalized linear models)  

If you have any doubt about your preparation for this course, feel free to chat with me on the first day.  

One final observation: this course is focused on the statistical and algorithmic principles needed to confront large data sets.  It is not, at least primarily, about the practical issues associated with gathering, storing, cleaning, curating, and managing large data sets.  These things are super important, and we'll certainly encounter some of them.  But they're highly field dependent: if you're a linguist or a finance person, you'll be working with entirely different software and database systems than if you're a neuroscientist or an infectious-disease researcher.  And unfortunately, I can't teach them all.  

A corollary of this is that, if you're coming to this course hoping to learn a particular software stack that will send you out into industry as a big-data guru, you will almost certainly end up disappointed.  However, if you come here hoping to understand the deeper principles behind any serious attempt at analyzing big data, then this is the course for you.  You will have to do some work on your own to marry these principles with the practical software skills appropriate for your chosen field.  But I can promise you that your efforts will be rewarded, and that you'll be set up for far more lasting success than the guy whose expertise consists of a week on Coursera learning how to use Spark to run some black-box machine-learning algorithm on a terabyte of data.  




## Assignments

### Preliminaries

The goal of this warm-up assignment is to provide you with an introduction to optimization and its role in data analysis.  

For this section, please read Chapter 2 of _Numerical Optimization_, by Nocedal and Wright.  The full text of this book is available for free through the [UT Library website](http://lib.utexas.edu).  You should come away with a good general understanding of two methods for optimizing smooth functions:  
1) the method of steepest descent, or simply _gradient descent_, and   
2) Newton's method.  

Feel free to skip the stuff about trust-region methods.  The overview of quasi-Newton methods is nice, but optional for now.  

The [exercises for this unit](exercises/exercises01/exercises01-SDS385.pdf) will have you practice these techniques.  They will also will hammer your linear algebra skills.  
