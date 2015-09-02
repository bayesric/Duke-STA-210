# Optional Assignment (Lab 2)
# STA 210: Regression Analysis (2015 Fall)
# Author: <your name>

# Assignment
#************************************
# This assignment explors the statistical power
# of ANOVA F test with respect to the sample size.
# This assignment is OPTIONAL!
#************************************

# Step 1: Simulate 20 datasets with different sample sizes
n   <- seq(50,1000,50)
dat <- list() # Datasets for group 1
mu1 <- 0 # Mean for group 1
mu2 <- 1 # Mean for group 2
sd  <- 4 # standard deviation
for (i in 1:20){
  # Create a dataframe containing the data "x" and the group index variable "group"
  # Then store the dataframe into the i th element of the list "dat"
  # group 1 data is distributed as a norm with mean mu1 and standard deviation sd
  # group 2 data is distributed as a norm with mean mu2 and standard deviation sd
  # Replace <...your code here...> with your code
  dat[[i]] <- data.frame(x=<...your code here...>, 
                         group = c(rep(1,n[i]),rep(2,n[i])))
}

# Step 2: Apply ANOVA on these 20 datasets and store the 20 p-values into a vector
pval <- rep(NA,10)
for (i in 1:20){
  # Run one way ANOVA on x and acuqire the p value for the following null hypothesis
  # H0: mu1 = mu2
  tmp <- summary(<...your code here...>)
  pval[i] <- tmp[[1]][1,5] # extract the p value from the ANOVA summary object
}

# Step 3: Draw the p-values against the associated sample sizes
# label the y axis "p value", label the x axis "Sample size"
<...your code here...>