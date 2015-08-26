# Lab1_BasicR
# by Ye (Eric) Wang
# A breif introduction of R language

# Section 0: R & Rstudio Installation
#*************************************
# http://www.r-project.org/
# https://www.rstudio.com/
# 0.1 Basic Layout of Rstudio
# 0.2 Change Appearance
# 0.3 Install Packages
#    0.3.1 From CRAN
#    0.3.2 From Local Files
#*************************************

# Section 1: Basic Commands
#*************************************
# 1.1 Calculator
20^3/4 + 15

# 1.2 Workspace
# Create variables (objects) using "<-" or "="
# "<-" is basically the same as "="
# "<-" is also used in S, which is the ancester of R
a <- 20^3/4 + 15
b =  20^3/4 + 15

# 1.3 comment
# Use "#" for comment
# Rstudio trick: Use "#Title----" or "#Title####" to control a block of data
# example:
# block 1----
# This
# is
# a
# block
a <- 20^3/4 + 15
# block 2----
# This
# is
# another
# block
b =  20^3/4 + 15
#*************************************

# Section 2: Data Structure
#*************************************
# 2.1 Vector
v1 <- c(2008,a,20*b,1000)
v1[2]
v1[c(1,3,4)]
# Some quick ways of creating a vector
v2 <- 1:10
v3 <- seq(from=1,to=10,by=1)
v2
v3
v4 <- rep("ha",5)
v4
# 2.2 Matrix
m <- matrix(v1,2,2)
m
m[1,2]
m[1,]
m[,2]

# 2.3 Dataframe
# A matrix with column names
df <- data.frame(m)
df
colnames(df)
colnames(df) <- c("name1","name2")
df <- data.frame(name1 = m[,1], name2 = m[,2])
# You can call the column name without knowing its position
df$name1
# For simplicity, you can also attach the dataframe to the current environment
name1
attach(df)
name1
# Remember to detach the dataframe
detach(df)
name1

# 2.4 List
# List is a collection of objects, not necessarily the same type
li <- list(a = a,
           m = m,
           df = df)
li$df
# You can also attach a list
#*************************************

# Section 3: Functions
#*************************************
# 3.1 Use functions
help(mean)
example(mean)
mean(x=a)
# You should be able to drop the argument for simplicity in most of the cases
# but it might cause some trouble in some very rare cases
mean(a)

# 3.2 Write functions
myfun1 <- function(arg1,arg2){
  return(arg1 + arg2)
}
myfun2 <- function(arg1,arg2){
  arg1 + arg2
}
# Both okay, explicitly calling return() gives clear "leave" signal for the function
myfun1(1,2)
myfun2(1,2)
#*************************************

# Section 4: Basic Programming
#*************************************
# 4.1 If-statement
w <- 5
if (w < 3){
  d <- 1
}else if (w >= 5){
  d <- 2
}else{
  d <- 3
}
d
# A possible bug
w <- -4
if (w<-5){
  # Space is important!
  d <- 2
}
w
d

# 4.2 For-loop
tmp <- 0
for (i in 1:10){
  tmp <- tmp + i
}
tmp
h <- c(1,3,7,8,9)
tmp <- 0
for (i in h){
  tmp <- tmp + i
}
tmp
# h can be a vector of any type
h <- c("H","E","L","L","O","!")
for (i in h){
  cat(i,"\n")
}
#*************************************
