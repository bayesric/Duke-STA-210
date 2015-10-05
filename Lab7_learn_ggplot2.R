# Lab 7
# Created by Ye (Eric) Wang
# on 10/04/2015
# In this lab we will do some cool data visualization on
# a real-world dataset on housing values on suburbs of Boston

# library
#******************************************************
library(ggplot2)
library(RColorBrewer)
#******************************************************

# import data
#******************************************************
housing <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
names(housing) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", 
                    "RAD", "TAX", "PTRATIO", "B",  "LSTAT", "MEDV")
# 1. CRIM      per capita crime rate by town
# 2. ZN        proportion of residential land zoned for lots over 25,000 sq.ft.
# 3. INDUS     proportion of non-retail business acres per town
# 4. CHAS      Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
# 5. NOX       nitric oxides concentration (parts per 10 million)
# 6. RM        average number of rooms per dwelling
# 7. AGE       proportion of owner-occupied units built prior to 1940
# 8. DIS       weighted distances to five Boston employment centres
# 9. RAD       index of accessibility to radial highways
# 10. TAX      full-value property-tax rate per $10,000
# 11. PTRATIO  pupil-teacher ratio by town
# 12. B        1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
# 13. LSTAT    % lower status of the population
# 14. MEDV     Median value of owner-occupied homes in $1000's
#******************************************************

## Grammar Defines Components of Graphics 
# "Introduction to ggplot2" by Dawn Koffman
# Office of Population Research
# Princeton University
# January 2014
# 1. data: in ggplot2, data must be stored as an R data frame
# 2. aesthetics: describe visual characteristics that represent data
#    - for example, position, size, color, shape, transparency, fill
# 3. geoms: describe type of geometric objects that represent data
#    - for example, points, lines, polygons, ...

# Histogram of MEDV
medv_hist <- ggplot(data = housing, aes(x = MEDV))
medv_hist <- medv_hist + geom_bar()
# or equivalently
# medv_hist <- ggplot()
# medv_hist <- medv_hist + geom_bar(data = housing, aes(x = MEDV))
medv_hist

# Density plot of MEDV
medv_den <- ggplot(data = housing, aes(x = MEDV))
medv_den <- medv_den + geom_density()
medv_den

# Scatterplot of MEDV against RM
medv_rm_scatter <- ggplot(data = housing, aes(x = RM, y = MEDV))
medv_rm_scatter <- medv_rm_scatter + geom_point()
medv_rm_scatter

# 4. scales: for each aesthetic, describe how visual characteristic is converted to display values
#    - for example, log scales, color scales, size scales, shape scales, ...

# Create a prettier density plot of MEDV
medv_den <- ggplot(data = housing, aes(x = MEDV))
medv_den <- medv_den + geom_density(fill = "blue", alpha = 0.3)
medv_den

# Use color to distinguish between two groups
medv_rm_scatter <- ggplot(data = housing, aes(x = RM, y = MEDV, color = factor(CHAS)))
medv_rm_scatter <- medv_rm_scatter + geom_point()
medv_rm_scatter
# Make them taking different shapes as well!
medv_rm_scatter <- ggplot(data = housing, aes(x = RM, y = MEDV, 
                                              color = factor(CHAS), shape = factor(CHAS)))
medv_rm_scatter <- medv_rm_scatter + geom_point()
medv_rm_scatter

# 5. stats : describe statistical transformations that typically summarize data
#    - for example, counts, means, medians, regression lines, ...

# Add a smoother to the scatterplot
medv_rm_scatter <- ggplot(data = housing, aes(x = RM, y = MEDV))
medv_rm_scatter <- medv_rm_scatter + geom_point()
medv_rm_scatter <- medv_rm_scatter + stat_smooth()
medv_rm_scatter

# hmm... I want a linear regression smoother
medv_rm_scatter <- ggplot(data = housing, aes(x = RM, y = MEDV))
medv_rm_scatter <- medv_rm_scatter + geom_point()
medv_rm_scatter <- medv_rm_scatter + stat_smooth(method = "lm")
medv_rm_scatter

# 6. facets: describe how data is split into subsets and displayed as multiple small graphs

# Let's do some more scatterplot
medv_rm_scatter <- ggplot(data = housing, aes(x = RM, y = MEDV))
medv_rm_scatter <- medv_rm_scatter + geom_point()
medv_rm_scatter <- medv_rm_scatter + stat_smooth(method = "lm")
medv_rm_scatter <- medv_rm_scatter + facet_grid(.~CHAS)
medv_rm_scatter

# Or another direction
medv_rm_scatter <- medv_rm_scatter + facet_grid(CHAS~.)
medv_rm_scatter

# Let's facet more!
medv_rm_scatter <- medv_rm_scatter + facet_grid(RAD~CHAS)
medv_rm_scatter

# 7. coordinate system: describes 2-D space that data is projected onto
#    - for example, Cartesian coordinates, polar coordinates, map projections, ...

## Extra cool stuff
# Theme: Overall Look
medv_den
medv_den <- medv_den + theme_bw()
medv_den
medv_den <- medv_den + theme_classic()
medv_den
medv_den <- medv_den + theme_minimal()
medv_den

# Or you can specify your own theme
medv_den <- medv_den + theme(panel.background = element_rect(fill = "cornsilk"),
                             panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                             plot.background = element_rect(fill = "lightblue1"))
medv_den

# and of course you can specify your xlab and ylab and the title as well
medv_den <- medv_den + ggtitle("Density Plot") + xlab("median value")
medv_den

# You can change everything! So much fun!
medv_den <- medv_den + theme(plot.title = element_text(colour = "red", size = 20))
medv_den

# Let's play more!
medv_den <- ggplot(data = housing, aes(x = MEDV, fill = factor(CHAS)))
medv_den <- medv_den + geom_density(alpha = 0.3)
medv_den <- medv_den + theme(panel.background = element_rect(fill = "cornsilk"),
                             panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                             plot.background = element_rect(fill = "lightblue1"),
                             legend.background = element_rect(fill = "lightblue1"))
medv_den <- medv_den + ggtitle("Density Plot") + xlab("median value")
medv_den