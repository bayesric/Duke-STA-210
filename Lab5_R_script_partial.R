# Lab 5
# Created by Ye (Eric) Wang
# on 09/19/2015

# 1. Case Study
#******************************************************
# 1.0 Load package "ggplot2"
# This is probably the best data visualization toolbox in R
# We will learn how to visualize our data using ggplot2 in lab 6
# And in this lab we will just warm up by using ggplot2 a little bit :)
library(ggplot2)

# 1.1 Load Gelman & Hill child data
# Source: http://faculty.smu.edu/kyler/courses/7312/interact.pdf
kidiq <- read.table("http://faculty.smu.edu/kyler/courses/7312/kidiq.txt",header = T)
# Returns the first or last parts of a vector, matrix, table, data frame or function
head(kidiq)
tail(kidiq)

# 1.2 Fit a multiple linear regression model: mean(kid.score) = a + b mom.hs + c mom.iq
<your code here>

# Now let's see the scatterplot of our data grouped by mom.hs
g1 <- ggplot(data=kidiq, aes(x = mom.iq, y = kid.score, color = factor(mom.hs)))
g1 <- g1 + geom_point() + scale_color_manual(guide = guide_legend(title = "mom.hs"), values=c("grey","cornflowerblue"))
g1 <- g1 + geom_abline(intercept = <the intercept for mom.hs=0>, slope = <the slope for mom.hs=0>, 
                     color = "grey", size = 1, alpha = 0.5)
g1 <- g1 + geom_abline(intercept = <the intercept for mom.hs=1>,
                     slope = <the slope for mom.hs=1>, color = "cornflowerblue",size = 1, alpha = 0.5)
g1 <- g1 + theme_bw() + xlab("mom IQ") + ylab("kid IQ") 
g1 <- g1 + ggtitle("Scatterplot: IQ scores of kids vs mom")
g1

# 1.3 Fit with interaction
m21 <- lm(kid.score ~ mom.hs + mom.iq + mom.hs:mom.iq, kidiq)
summary(m21)
m22 <- lm(kid.score ~ mom.hs*mom.iq, kidiq)
summary(m22)

# Now let's see the scatterplot of our data grouped by mom.hs
g2 <- ggplot(data=kidiq, aes(x = mom.iq, y = kid.score, color = factor(mom.hs)))
g2 <- g2 + geom_point() + scale_color_manual(guide = guide_legend(title = "mom.hs"), values=c("grey","cornflowerblue"))
g2 <- g2 + geom_abline(intercept = <the intercept for mom.hs=0>, slope = <the slope for mom.hs=0>, 
                     color = "grey", size = 1, alpha = 0.5)
g2 <- g2 + geom_abline(intercept = <the intercept for mom.hs=1>,
                     slope = <the slope for mom.hs=1>, color = "cornflowerblue",size = 1, alpha = 0.5)
g2 <- g2 + theme_bw() + xlab("mom IQ") + ylab("kid IQ")
g2 <- g2 + ggtitle("Scatterplot: IQ scores of kids vs mom")
g2

# 2. Dummy Coding Nominal Scale Variables
#******************************************************
# In fact something we did is not quite correct, do you know where is wrong?

# The variable mom.hs should be a nominal variable, but in fact
class(kidiq$mom.hs)
# However we accidentally got the correct inference results since the input variable 
# mom.hs is dummy coded. To be specific, mom.hs = 0 denotes the mom has not attended high school
# and mom.hs = 1 denotes that the mom has attended high school.
# For more details, read section 9.3.2 and 9.3.3 of the textbook
# We are just lucky here, but things might be completely wrong if 
# the nominal variable has more than 2 levels
kidiq210 <- kidiq
kidiq210$mom.edu <- sample(1:3,nrow(kidiq210),replace = TRUE)
m31 <- lm(kid.score ~ mom.edu + mom.iq + mom.hs:mom.iq, kidiq210)
summary(m31)
kidiq210$mom.edu <- sample(c(2,4,8),nrow(kidiq210),replace = TRUE)
m32 <- lm(kid.score ~ mom.edu + mom.iq + mom.hs:mom.iq, kidiq210)
summary(m32)
# So what is wrong with simply coding a nominal-scale variable with a interval-scale variable?
# In c(1,2,3) coding, you are assuming the difference between education level 1 and 2 is the same as
# the difference between education level 2 and 3, which is very likely to be not true!

# The correct way in R
m33 <- lm(kid.score ~ as.factor(mom.edu)*mom.iq, kidiq210)
summary(m33)
#******************************************************

# 3. Some Additional Questions
#******************************************************
# Now you have seen the interpretation of a two-way interaction between a continuous variable
# and a categorical variable. What is the interpretation of a two-way interaction between a 
# continuous variable and a continuous variable? A categorical variable between a categorical variable?
#******************************************************