source('sparse_factor.R')

social_marketing = read.csv('../data/social_marketing.csv')

X = social_marketing[,-c(1, 36, 37)]
X = X/rowSums(X)
Z = scale(X, center=TRUE, scale=FALSE)


lu = 0.3*sqrt(nrow(Z))
lv = 0.3*sqrt(ncol(Z))

out = find_one_factor(Z, lu, lv)
out$v
Z2 = out$residual
out2 = find_one_factor(Z2, lu, lv)
out2$v
