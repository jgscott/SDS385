source("linear_smoother.R")

utilities = read.csv("../data/utilities.csv")
utilities$dailybill = utilities$gasbill / utilities$billingdays

# reorder by temp
utilities = utilities[order(utilities$temp),]

plot(dailybill ~ temp, data=utilities)

# simple kernel smoothing
xstar = seq(9, 78, length=201)
out = kernel_smooth(utilities$temp, utilities$dailybill, xstar, 5)

plot(dailybill ~ temp, data=utilities)
lines(out~xstar, col='blue')


# cross validation: mean function
# using local linear regression
hgrid = 10^seq(0.5, 2, length=50)
outcv = locreg.cv(utilities$temp, utilities$dailybill, deg=1, hgrid)
plot(dailybill ~ temp, data=utilities)
lines(outcv$ystar ~ temp, data=utilities, col='blue')

# cross validation: variance function
# using local linear regression
eps = utilities$dailybill - outcv$ystar
z = log(eps^2)
outcv2 = locreg.cv(utilities$temp, z, deg=1, hgrid)
plot(z ~ temp, data=utilities)
lines(outcv2$ystar ~ temp, data=utilities, col='blue')

plot(eps^2 ~ temp, data=utilities)

# pointwise standard errors
sig_hat = sqrt(exp(outcv2$ystar))
H = outcv$H
h_norm = rowSums(H^2)
std_err = sqrt(h_norm)*sig_hat

# pointwise confidence intervals
plot(dailybill ~ temp, data=utilities)
lines(outcv$ystar ~ temp, data=utilities, col='blue')
lines(outcv$ystar + 1.96*std_err ~ temp, data=utilities, col='red')
lines(outcv$ystar - 1.96*std_err ~ temp, data=utilities, col='red')

