# SDS385

Welcome to SDS 385, a Ph.D.-level course on statistical models for big data.  All course materials can be found through this GitHub page.  

Some course logistics   
- Instructor: James Scott, <http://jgscott.github.com>  
- Meets: Mondays and Wednesday, 9:30 - 11:00 AM
- Classroom: Parlin 103
- Unique number: 56960

## Exercises 

[You can find all the exercises here.](exercises/)  I'll post them as they become relevant throughout the semester.

## Peer evaluation  

For the purpose of peer evaluation, you can find links [to people's GitHub pages here](team/).  


## About the course

This is a [Moore-method](https://en.wikipedia.org/wiki/Moore_method) course.  There are no regular lectures.  You will work on the [exercises outside of class](exercises/).  When you come to class, you will share what you've done, and benefit from understanding what others have done.  There's nothing else to it.  We will end up covering less than in a traditional lecture-based course.  But what you learn, you will learn very deeply.  The trade-off is more than worth it.   

While the course is much more about methods and applications than about theory, we will need a fair bit of (not-too-hard) math.  To that end, I assume that you know the following topics well:  
- linear algebra  
- multivariable calculus  
- how to program in a language like R or Python  
- probability (although measure theory isn't necessary)  
- basic inferential statistics  
- regression (including some exposure to generalized linear models)  

If you have any doubt about your preparation for this course, feel free to chat with me on the first day.  

One important observation: this course is focused on the statistical and algorithmic principles needed to confront large data sets.  It is not, at least primarily, about the practical issues associated with gathering, storing, cleaning, curating, and managing large data sets.  These things are super important, and we'll certainly encounter some of them.  But they're highly field dependent: if you're a linguist or a finance person, you'll be working with entirely different software and database systems than if you're a neuroscientist or an infectious-disease researcher.  And unfortunately, I can't teach them all.  

A corollary of this is that, if you're coming to this course hoping to learn a particular software stack that will send you out into industry as a big-data guru, you will almost certainly end up disappointed.  However, if you come here hoping to understand the deeper principles behind any serious attempt at analyzing big data, then this is the course for you.  You will have to do some work on your own to marry these principles with the practical software skills appropriate for your chosen field.  But I can promise you that your efforts will be rewarded, and that you'll be set up for far more lasting success than the guy whose expertise consists of a week on Coursera learning how to use Spark to run some black-box machine-learning algorithm on a terabyte of data.  I've met that guy.  Don't be that guy.  

## Grading

Your grade consists of two pieces: 70% peer evaluation, and 30% final project.

### Peer evaluation

During the semester, you will be expected to do three main things on a recurring basis:  
1) Work on the problems and coding assignments outside of class, and document your code so that someone else can follow it.  You will post all of your code and materials on your GitHub page.  
2) Present your work in front of class, either up at the board or by hooking up your computer and showing us your code and results.  
3) Provide at least four "peer reviews" of others' code and analyses from their GitHub pages, so that everyone gets feedback.  You'll do this about once every 3-4 weeks, and I'll assign the reviewers randomly.  

At the end of the semester, everyone will (privately) turn in a document that summarizes their assessment of each person's contribution to the course.  Those who have helped others to learn, either by presenting excellent work in class, or by offering thoughtful peer reviews, will presumably get good evaluations.  I'll use these summaries to set the peer-evaluation grades.  (Note: I'll still have the final say here.)  

### Final project  

Pick some relevant topic that interests you.  Clear it with me ahead of time, and then do it!  Basically, I trust you to choose something that will optimize your own learning experience, and that will dovetail with your research and educational goals.  It certainly can overlap with your dissertation.  Examples:  
1) Analyze a data set from your own research, using techniques from class or closely related techniques.  
2) Invent a new technique and show how awesome it is.  
3) Prove something interesting about a procedure or algorithm related to what we're studying (admittedly unlikely, but certainly possible!)  
4) Read a paper, or a group of related papers, that expands on some topic we've covered in class.  Implement the method and benchmark it against something else.  

Final projects are due on the last class day of the semester: Monday, December 5.  

Note: options 1-3 above (analyze a data set, invent a new technique, prove something) constitute honest-to-God research.  You should feel free to work in a team if do you one of these; you might end up publishing a paper.  For example, a fantastic outcome would be if a CS/Stats student teamed up with a Bio/Neuro student to help solve some actual scientific problem using a technique related to what we're covering.  

If you take option 4, you should turn in your own project.  

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
- The importance of multiplicity considerations (multiple comparisons, multiple testing) in big-data analysis  
- Matrix factorization and its applications (e.g. recommender systems, modeling covariance matrices)    
- Modeling non-numerical (e.g. binary/ordinal/text) data  
- Latent-variable models at scale  
- Resampling-based methods at scale  
- Big spatial models  

