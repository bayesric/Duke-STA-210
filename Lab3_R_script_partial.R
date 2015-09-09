# Lab 3
# Created by Ye (Eric) Wang
# on 09/09/2015

# 0. set.seed
#******************************************************
set.seed(1000)
# Computer uses some deterministic algorithm to generate suedo random numbers
# and manually specifying the argument of set.seed function tells the computer
# to "grow random numbers from a specific seed". This enables us to 
# generate a set of exact samle "random" numbers at different time or even using
# different computers. (Very important in reproducible experiments!)
#******************************************************

# 1. Do by Yourself
#******************************************************
# R functions you might need in this lab:
# rnorm, rcauchy, exp, log, qqnorm, qqline, hist, density, line

# to-do-list 1:
# simulate 4 different y's (y1, y2, y3, y4)

# 1.1 simulate 1000 standard normal rv and set "y1" to be the exponent of them
# <your code below>

# 1.2 simulate 1000 standard normal rv and set "y2" to be the logarithm of the absolute values of them
# <your code below>

# 1.3 simulate 1000 standard Cauchy rv as "y3"
# <your code below>

# 1.4 simulate 1000 normal rv as "y4"
# <your code below>

# to-do-list 2:
# plot 4 qq plots for each of the 4 y's coupled with the corresponding histograms
# with smooth estimated densities overlayed on top. Plot these 8 figures in a single plot
# with 2 rows and 4 columns.

# 2.0 partition the plotting area into 2 rows and 4 columns
# <your code below>

# 2.1 draw qq plots for all four y's (use both qqnorm and qqline)
# <your code below>

# 2.2 draw histogram for all four y's (use both hist and density)
# <your code below>

#******************************************************

# 2. log transformation
#******************************************************
dev.off()
qqnorm(log(y1))
qqline(log(y1))
#******************************************************