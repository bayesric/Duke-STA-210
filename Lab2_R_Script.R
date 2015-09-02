# Lab 2
# Created by Ye (Eric) Wang
# Modified largely from the code by Prof. Jerry Reiter
# on 09/01/2015

# 0. Optional Assignment of Lab 1

# 1. Install R Packages
#******************************************************
# Install from CRAN ("randomForest")
# or install from local files ("lrpd")
library("randomForest")
library("lrpd")
#******************************************************

# 2. Set working directory
#******************************************************
# This returns the current directory
getwd()
# Change the directory
setwd("C:/Users/Eric Wang/Dropbox/DukePhD Semester 3/STA 201 (TA)/Lab 2")
#******************************************************

# 3. Read data
#******************************************************
cpsdata = read.csv("cpsdata.txt", header = T)
#******************************************************

# 4. Exploratory Data Analysis (EDA)
#******************************************************
#Let's look at the first 5 rows of the data file.

#Let's delete the first column which is redundant

#Let's look at the first 5 values of the first column (total alimony payments in the house)

#You can get summaries of all the variables at once
summary(cpsdata)

#Let's list the names of the variables in the file -- the actual definitions are in the Sakai folder

#Let's get some basics about the file.  First, how many rows (people) does it have.
nrow(cpsdata)

# Now the number of columns
ncol(cpsdata)

#Let's see how many people are males (ASEX==1) and females (ASEX==2) on the file.
table(cpsdata$ASEX)

#Really, we want percentages rather than counts.  So, we divide by the sample size.
table(cpsdata$ASEX)/nrow(cpsdata)

#Note how we divide every element of the vector by the sample size--R is smart enough to do so automatically!

#This result has a messy appearance.  Let's round the values to the nearest .001
round(table(cpsdata$ASEX)/nrow(cpsdata), 3)

#Let's also take into account the counts for marital status (1 = married, 4 = widowed, 5 = divorced, 6 = separated, 7 = single;
mytable <- table(cpsdata$ASEX,cpsdata$AMARITL) # A contingency table
margin.table(mytable, 1) 
margin.table(mytable, 2)
round(prop.table(mytable),3) # cell percentages
round(prop.table(mytable, 1),3) # row percentages 
round(prop.table(mytable, 2),3) # column percentages

#We'll look a lot at income (HTOTVAL).  Let's make a histogram.
attach(cpsdata)
hist(HTOTVAL)

#It is always good practice to add titles to graphs
hist(HTOTVAL, xlab="Income", main = "Histogram of income")

#If you want the vertical axis of the histogram to report density rather than counts
hist(HTOTVAL, xlab="Income", main = "Histogram of income", prob=T)

#It is a good idea to examine histograms with greater numbers of bins than the default, so
#that you can see more detail about the distribution.  Here is a histogram with 50 bins.
hist(HTOTVAL, xlab="Income", main = "Histogram of income", prob=T, breaks = 50)

#Now 100 bins
hist(HTOTVAL, xlab="Income", main = "Histogram of income", prob=T, breaks = 100)

#You can estimate the density of income from the data using 
incdens = density(HTOTVAL)

#You can plot this curve on top of the histogram (in orange) using
lines(incdens, col = "orange")

#The density estimator is based on collections of normal distributions.  If you change the
#standard deviation of those normal distributions, you can get different pictures.  This can
#be useful if the density is ragged and you want to see a smoother version.  Here is the
#density with twice the standard deviation as the default.  You can change the number after
#adjust to get other pictures. 

incdens = density(HTOTVAL, adjust = 2)
lines(incdens, col = "red")

#Box plots are useful for seeing distributions of data.  Here is a box plot of income.
boxplot(HTOTVAL, xlab = "Income")

#They are even more useful for comparing distributions for people in different categories.
#Here is a side-by-side box plot of income for men and women
boxplot(HTOTVAL~ASEX, xlab = "Sex (1 = male, 2 = female)")

#Now for marital status
boxplot(HTOTVAL~AMARITL, xlab = "Marital Status")


#If you ever want to close the graphics window and start over, type
dev.off()

#Quantile-quantile plots are especially useful for comparing distributions
#The most common QQ plot is a comparison of the variable against a normal distribution.
qqnorm(HTOTVAL)

#If the variable follows a normal, the QQ plot should show a straight line.  Otherwise, it
#will show a curve, just like the plot for income. You can add the straight line indicating
#what should appear if the data were normally distributed using
qqline(HTOTVAL)

# Remove HTOTVAL that are no greater than 0 and do a power 0.3 transformation
# then do the QQ plot again
qqnorm((HTOTVAL[HTOTVAL>0])^.3)
qqline((HTOTVAL[HTOTVAL>0])^.3)

# Group the data by sex and do the above once again
qqnorm((HTOTVAL[HTOTVAL>0&ASEX==1])^.3)
qqline((HTOTVAL[HTOTVAL>0&ASEX==1])^.3)

qqnorm((HTOTVAL[HTOTVAL>0&ASEX==2])^.3)
qqline((HTOTVAL[HTOTVAL>0&ASEX==2])^.3)

# ANOVA
summary(aov(HTOTVAL~ASEX))

#For two continuous variables, the scatter plot is an effective EDA tool.  Let's plot income
#versus property taxes.
plot(y=HTOTVAL, x=PROPTAX, xlab="Property Tax", ylab="Income", main = "Income versus property tax")

#Let's remove all the people who don't own a home (i.e., have taxes == 0)
plot(y=HTOTVAL[PROPTAX>0], x=PROPTAX[PROPTAX>0], ylab="Income", xlab = "Property tax", main = "Income versus property tax for homeowners")

#We can add a smooth trend to the data using the lowess command.
lines(lowess(HTOTVAL[PROPTAX>0]~PROPTAX[PROPTAX>0]))

#to get a matrix of scatter plots involving multiple variables, use 
pairs(HTOTVAL~PROPTAX+SSVAL+AHGA)

#what if we wanted the relationship between income and education for males only?
plot(HTOTVAL[ASEX==1] ~ AHGA[ASEX==1], xlab = "Education", ylab = "Income", main = "Income and education for males only")

#now for females only
plot(HTOTVAL[ASEX==2] ~ AHGA[ASEX==2], xlab = "Education", ylab = "Income", main = "Income and education for females only")

#we can put 2 graphs on the same page (as 2 rows and 1 column) by using
par(mfcol=c(2,1))

#then, we call for the two graphs
plot(HTOTVAL[ASEX==1] ~ AHGA[ASEX==1], xlab = "Education", ylab = "Income", main = "Income and education for males")
plot(HTOTVAL[ASEX==2] ~ AHGA[ASEX==2], xlab = "Education", ylab = "Income", main = "Income and education for females")

#get back to one graph per page
par(mfcol = c(1,1))
#******************************************************

# Practice
#******************************************************
# 1. Draw boxplots of HTOTVAL for different ARACE
# 2. Check the normality of HTOTVAL for each ARACE (race), draw the QQ plots
# 3. Summary the results of the one-way ANOVA of HTOTVAL agains ARACE
# 4. Explain the quantities in the results
#******************************************************