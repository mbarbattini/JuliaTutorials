using LsqFit

# define the equation the data should be fitted to
# p is an array of all the parameters
@. model(x, p) = p[1]*x+p[2]
# initial guess
p0 = [0.5, 0.5]
# create some data
xdata = range(0, stop=10, length=20)
ydata = model(xdata, [1.0 2.0]) + 0.01*randn(length(xdata))
plot(xdata, ydata)
# fit the data to the model
fit = curve_fit(model, xVals, yVals, p0)
# values of the parameters
coef(fit)



# xVals = [0.5, 4, 12, 8, 24, 48, 12, 24, 24, 80]
# yVals = [5.2, 36, 107, 63.5, 190, 300, 116, 216, 235, 630]
# scatter(xVals, yVals)
