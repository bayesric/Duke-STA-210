# Ways to visualize time series (longitudinal data)
# By Ye Wang (Eric)
# 11/06/2015

library(ggplot2)
library(nlme) # Contains lots of longitudinal data!

# An example
data(Milk)
# This data frame contains the following columns:
#protein a numeric vector giving the protein content of the milk.
#Time a numeric vector giving the time since calving (weeks).
#Cow an ordered factor giving a unique identifier for each cow.
#Diet a factor with levels barley, barley+lupins, and lupins identifying the diet for each cow.

# Lines
g1 <- ggplot()
g1 <- g1 + geom_line(data = Milk, aes(x = Time, y = protein, group = Cow))
g2 <- g2 + geom_point(data = Milk, aes(x = Time, y = protein, group = Cow))
g1 <- g1 + theme_bw()
g1

g2 <- ggplot()
g2 <- g2 + geom_line(data = Milk, aes(x = Time, y = protein, group = Cow, color=Diet),alpha = 0.4)
g2 <- g2 + geom_point(data = Milk, aes(x = Time, y = protein, group = Cow, color=Diet))
g2 <- g2 + theme_bw()
g2

g3 <- ggplot()
g3 <- g3 + geom_line(data = Milk, aes(x = Time, y = protein, group = Cow),alpha = 0.4)
g3 <- g3 + geom_point(data = Milk, aes(x = Time, y = protein, group = Cow))
g3 <- g3 + facet_grid(Diet~.)
g3 <- g3 + theme_bw()
g3

# Stacked bar plot
m1 <- apply(as.matrix(unique(Milk$Time)),1,FUN=function(x){
  mean(Milk$protein[Milk$Time==x & Milk$Diet=="barley"])
  })
m2 <- apply(as.matrix(unique(Milk$Time)),1,FUN=function(x){
  mean(Milk$protein[Milk$Time==x & Milk$Diet=="barley+lupins"])
})
m3 <- apply(as.matrix(unique(Milk$Time)),1,FUN=function(x){
  mean(Milk$protein[Milk$Time==x & Milk$Diet=="lupins"])
})
df <- data.frame(protein = c(m1,m2,m3),
                 Time = c(unique(Milk$Time),unique(Milk$Time),unique(Milk$Time)),
                 Diet = as.factor(c(rep("barley",19),rep("barley+lupins",19),rep("lupins",19))))
g4 <- ggplot()
g4 <- g4 + geom_bar(data=df, aes(x = Time, y = protein, fill=Diet), stat='identity')
g4 <- g4 + theme_bw()
g4

# Covariance structures
library(mvtnorm)
T <- 300
# 1. Identity Covariance matrix
y <- rnorm(T)
plot(1:T,y,'l')
plot(y[1:T-1],y[2:T])
acf(c(y))
# 2. compound symmetric or exchangeable structure
SIGMA <- matrix(0.5,T,T)
diag(SIGMA) <- 1
y <- rmvnorm(1,sigma = SIGMA)
plot(1:T,y,'l')
plot(y[1:T-1],y[2:T])
acf(c(y))
# 3. AR(1)
SIGMA <- matrix(1,T,T)
for (i in 1:T){
  for (j in 1:T){
    SIGMA[i,j] <- 0.9^{abs(j-i)}
  }
}
y <- rmvnorm(1,sigma = SIGMA)
plot(1:T,y,'l')
plot(y[1:T-1],y[2:T]) # Why it is called auto-regressive
acf(c(y))
