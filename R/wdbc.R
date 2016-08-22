wdbc = read.csv('../data/wdbc.csv', header=FALSE)

y = wdbc[,2]
X = as.matrix(wdbc[,-c(1,2)])
scrub = which(1:ncol(X) %% 3 == 0)
scrub = 11:30
X = X[,-scrub]

glm1 = glm(y~X, family='binomial')
