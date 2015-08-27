# Optional Assignment (Lab 1)
# STA 210: Regression Analysis (2015 Fall)
# Author: <your name>

# Assignment
#************************************
# Write a function that sort a vector into ascending order
# Please post the solution on Github and send the link of the repository
# to me via email. Or if you are not comfortable with Github, you can directly
# send me the R script. 
# This assignment is OPTIONAL!
#************************************

# I have written a skeleton for this function
# All you need to do is to fill your code in and make it run without problem
# Have fun!

mysort <- function(arg){
  # Sort a vector into ascending order.
  #
  # Args:
  #   arg: the vector to be sorted.
  #
  # Returns:
  #   The sorted vector.
  n   <- length(arg) # length of arg
  res <- rep(NA,n) # your result
  
  # Fill in you own code here
  
  
  #**************************
  return(res)
}

# Test your function
v <- rnorm(10)
v
# See if v is correctly sorted into a ascending order
mysort(v)
