# Optional Assignment (Lab 2)
# STA 210: Regression Analysis (2015 Fall)
# Author: Eric

# Step 1: Simulate 20 datasets with different sample sizes
n   <- seq(50,1000,50)
dat <- list() # Datasets for group 1
mu1 <- 0 # Mean for group 1
mu2 <- 1 # Mean for group 2
sd  <- 4 # standard deviation
for (i in 1:20){
  dat[[i]] <- data.frame(x = c(mu1 + sd*rnorm(n[i]),mu2 + sd*rnorm(n[i])),
                         group = c(rep(1,n[i]),rep(2,n[i])))
}

# Step 2: Apply ANOVA on these 20 datasets and store the 20 p-values into a vector
pval <- rep(NA,10)
for (i in 1:20){
  tmp <- summary(aov(x~group,data=dat[[i]]))
  pval[i] <- tmp[[1]][1,5]
}

# Step 3: Draw the p-values against the associated sample sizes
# label the y axis "p value", label the x axis "Sample size"
plot(1:20,pval,'l',xlab = "Sample size", ylab = "p value")