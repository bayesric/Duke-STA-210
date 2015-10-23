library(arm)
library(ggplot2)

# Read data
credit <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/credit-screening/crx.data",sep = ",")
# Remove missing data
credit[credit == "?"] <- NA
credit <- credit[complete.cases(credit),]
# Correct the numerical type
credit$V2 <- as.numeric(levels(credit$V2))[credit$V2]
credit$V14 <- as.integer(levels(credit$V14))[credit$V14]
# Correct the factors
credit$V1 <- factor(credit$V1)
credit$V4 <- factor(credit$V4)
credit$V5 <- factor(credit$V5)
credit$V6 <- factor(credit$V6)
credit$V7 <- factor(credit$V7)
credit$V9 <- factor(credit$V9)
credit$V10 <- factor(credit$V10)
credit$V12 <- factor(credit$V12)
credit$V13 <- factor(credit$V13)
credit$V16 <- factor(credit$V16)

# EDA
attach(credit)
# discrete variable
tab <- table(V16,V10)
# Continuous variable
boxplot(V11~V16)
dummycode <- rep(1,nrow(credit))
dummycode[V16=="-"] <- 0
binnedplot(x= V11, y= dummycode, nclass = 10, xlab = "Binned V11")

symb = rep(2,length(dummycode))
symb[dummycode==1] = 19
plot(x=V11, y=V8, type = "p",pch=symb) #type="p" specifies you want point

symb = rep("-",length(dummycode))
symb[dummycode==1] = "+"
plot(x=V11, y=V8, type = "p",pch=symb) #type="p" specifies you want point

g <- ggplot()
#g <- g + geom_point(data = credit,aes(x = V11, y = V8, shape = V16),size=4)
g <- g + geom_jitter(data = credit,aes(x = V11, y = V8, shape = V16),size=4,position = position_jitter(width = 3, height = 3))
g <- g + geom_point(data = credit,aes(x = V11, y = V8, color = V16),size=4,alpha=0.3)
g <- g + coord_cartesian(xlim = c(-4,25), ylim = c(-4,22))
g <- g + scale_shape_manual(values = c(45,43))
g <- g + theme_bw()
g

g <- ggplot()
g <- g + geom_jitter(data = credit,aes(x = V11, y = V8, color = V16, size = V3/mean(V3)),alpha=0.5)
g <- g + coord_cartesian(xlim = c(-1,25), ylim = c(-1,22))
g <- g + theme_bw()
g

# Fit a logistic regression
# Comparing two models
model1 <- glm(V16 ~V10 + V11 + V8, data = credit, family = binomial)
summary(model1)
model2 <- glm(V16 ~V1 + V10 + V11 + V8, data = credit, family = binomial)
summary(model2)
a <- anova(model1,model2)
1-pchisq(a$Deviance[2],df=1) # p-value
